//
//  ChatViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 3/4/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftEventBus
import ImagePickerSheetController
import Photos
import SwiftSpinner

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var data:[Message] = []
    var threadId:String!
    var recipient:String!
    var theImage:UIImage!
    
    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    
    let dropShawdow = DropShadow()
    let presenter = PresentMessage()
    let theCloud = Cloud()
    let currentUser = UserClient().currentUser()
    let file = WallClient()
    
    override func viewWillAppear(animated: Bool) {
        
        getMessages()
        
        print("Recipient is \(recipient)")
        
        self.navigationController?.navigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onMainThread(self, name: "NewMessage") { (result) in
            
            self.getMessages()
            
            self.stopSpin()
            
            print("got new message")
        }
        
        dropShawdow.shadow(navView, color: UIColor.darkGrayColor())

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        SwiftEventBus.unregister(self, name: "NewMessage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startSpin(){
        
        SwiftSpinner.show("Uploading").addTapHandler({
            SwiftSpinner.hide()
            }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
    }
    
    func stopSpin(){
        
        SwiftSpinner.hide()
    }
    
    func scrollToBottom(animated: Bool = true) {
        let sections = self.tableView.numberOfSections
        let rows = self.tableView.numberOfRowsInSection(sections - 1)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: rows - 1, inSection: sections - 1), atScrollPosition: .Bottom, animated: true)
    }
    
    @IBAction func send(sender: AnyObject) {
        
        if theImage != nil {
            
            let message = Message(theDescription: textField.text!)
            
            presenter.sendMessageWithImage(message,image:theImage,recipent:recipient)
            startSpin()
            theImage = nil
            
        }else if textField.text != "" {
            
            let message = Message(theDescription: textField.text!)
            presenter.sendMessage(message,recipent:recipient)
            textField.text = ""
        }
        
    }
    
    @IBAction func camera(sender: AnyObject) {
        
        let manager = PHImageManager.defaultManager()
        let initialRequestOptions = PHImageRequestOptions()
        initialRequestOptions.resizeMode = .Fast
        initialRequestOptions.deliveryMode = .HighQualityFormat
        
        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
            let controller = UIImagePickerController()
            controller.delegate = self
            var sourceType = source
            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
                sourceType = .PhotoLibrary
                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
            }
            controller.sourceType = sourceType
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        let controller = ImagePickerSheetController(mediaType: .Image)
        controller.maximumSelection = 1
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use This Image", comment: "Action Title"), handler: { _ in
            presentImagePickerController(.Camera)
            }, secondaryHandler: { action, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                    options:initialRequestOptions) { (finalResult, _) in
                        
                        self.theImage = finalResult
                        self.cameraBtn.setImage(self.theImage, forState: UIControlState.Normal)
                        print(finalResult)
                }
                
                
        }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Photo Library", comment: "Action Title"), secondaryTitle: { NSString.localizedStringWithFormat(NSLocalizedString("ImagePickerSheet.button1.Send %lu Photo", comment: "Action Title"), $0) as String}, handler: { _ in
            presentImagePickerController(.PhotoLibrary)
            }, secondaryHandler: { _, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                options:initialRequestOptions) { (finalResult, _) in
                    
                    self.theImage = finalResult
                    self.cameraBtn.setImage(self.theImage, forState: UIControlState.Normal)
                    print(finalResult)
                }
        }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: { _ in
            print("Cancelled")
        }))
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.modalPresentationStyle = .Popover
            controller.popoverPresentationController?.sourceView = view
            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    

// MARK: UIImagePickerControllerDelegate

func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
}

func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    
    theImage = image
    dismissViewControllerAnimated(true, completion: nil)
}
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tableView.reloadData()
            
            if self.data.count > 0 {
                
                self.scrollToBottom(true)
            }
        }
    }
    
    func getMessages(){
        
        self.data.removeAll()
        
        self.presenter.getMessages(recipient) { (data) in
            
            self.data = data
            
            self.reload()
            
            print("Reloaded Messges")
            
            print("we have \(self.data.count) messages")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // let date:NSDate = self.data[indexPath.row].date!
        //let time = NSDate().offsetFrom(date)
        
        if data[indexPath.row].media != nil {
            
            let imageCell = tableView.dequeueReusableCellWithIdentifier("image") as! MessageImageCell
            
            file.getFile(data[indexPath.row].media!, completion: { (data) in
                
                imageCell.sentImage.kf_setImageWithURL(data, placeholderImage:UIImage(named: "placeholder"))
            })
            
            imageCell.msg.text = data[indexPath.row].messageText
            imageCell.name.text = data[indexPath.row].sender
            //imageCell.time.text = time
            
            return imageCell
        
        }else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
            
            cell.message.text = data[indexPath.row].messageText
            cell.userName.text = data[indexPath.row].sender
            //cell.time.text = time
            
            if data[indexPath.row].sender != currentUser.username  {
                
                cell.bar.image = UIImage(named: "msgred")
                cell.userName.textColor = UIColor.lightGrayColor()
                
            }else {
                
                cell.bar.image = UIImage(named: "msgblue")
                cell.userName.textColor = UIColor.darkTextColor()
            }
            
            return cell
        }
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if data[indexPath.row].media != "" {
            
           self.performSegueWithIdentifier("showImage", sender: indexPath)
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showImage" {
            
            let indexPath = sender as! NSIndexPath
            
            let controller = segue.destinationViewController as! ChatImageController
            
            print(data[indexPath.row].media)
            
            controller.image = data[indexPath.row].media
            controller.recipient = recipient
        }
        
    }
    

}
