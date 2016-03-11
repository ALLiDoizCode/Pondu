//
//  ChatViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 3/4/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import Parse
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
    var objectId:String!
    var theImage:UIImage!
    
    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    let videoTypes:[String] = ["mov","mp4", "m4v","3gp","MOV"]
    
    let currentUser = PFUser.currentUser()
    let dropShawdow = DropShadow()
    let presenter = PresentMessage()
    let theCloud = Cloud()
    
    override func viewWillAppear(animated: Bool) {
        
        print("msg id is \(objectId)")
        
        theCloud.addChannel(objectId)
        
        self.data.removeAll()
        
        self.presenter.messageWithId(self.objectId, completion: { (msgData) -> Void in
            
            self.data = msgData
            
            self.reload()
            
            self.textField.text = ""
            
            print("Reloaded Messges")
            
            print("we have \(self.data.count) messages")
            
        })
        
        self.navigationController?.navigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 246.0
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        theCloud.removeChannel(objectId)
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.data.removeAll()
        
        SwiftEventBus.onBackgroundThread(self, name: "New") { result in
            
            print("incoming push")
            
            self.presenter.messageWithId(self.objectId, completion: { (msgData) -> Void in
                
                self.data = msgData
                
                self.reload()
                
                self.stopSpin()
                
                self.textField.text = ""
                
                print("Reloaded Messges")
                
                print("we have \(self.data.count) messages")
                
            })
        }
        
        dropShawdow.shadow(navView, color: UIColor.darkGrayColor())

        // Do any additional setup after loading the view.
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
        
        
        SwiftEventBus.onMainThread(self, name: "updateMsg") { result in
            
            print("sending push with Image")
            
            self.cameraBtn.setImage(UIImage(named: "cameraImg"), forState: UIControlState.Normal)
            
            self.textField.text = ""
            
            self.theCloud.pushComment(self.objectId,type: "msg")
            
            SwiftEventBus.unregister(self, name: "updateMsg")
            
        }
        
        if theImage != nil {

            presenter.sendMessage(objectId, text: textField.text!,hasImage:true,image:theImage)
            startSpin()
            theImage = nil
            
        }else if textField.text != "" {
            
            presenter.sendMessage(objectId, text: textField.text!,hasImage:false,image:nil)
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let date:NSDate = self.data[indexPath.row].date
        let time = NSDate().offsetFrom(date)
        
        if data[indexPath.row].media != "" {
            
            let imageCell = tableView.dequeueReusableCellWithIdentifier("image") as! MessageImageCell
            
            imageCell.sentImage.kf_setImageWithURL(NSURL(string: data[indexPath.row].media!)!, placeholderImage:UIImage(named: "placeholder"))
            
            imageCell.msg.text = data[indexPath.row].description
            imageCell.name.text = data[indexPath.row].sender
            imageCell.time.text = time
            
            return imageCell
        
        }else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
            
            cell.message.text = data[indexPath.row].description
            cell.userName.text = data[indexPath.row].sender
            cell.time.text = time
            
            if data[indexPath.row].sender != currentUser?.username {
                
                cell.bar.image = UIImage(named: "msgred")
                cell.userName.textColor = UIColor.lightGrayColor()
            }
            
            return cell
        }
        
    }
    
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if data[indexPath.row].media != "" {
            
            
            return 246
            
        }else {
            
            return 86
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
