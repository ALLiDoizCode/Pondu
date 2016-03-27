//
//  SignUp2ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import ImagePickerSheetController
import Photos
import SwiftSpinner
import SwiftEventBus
import BubbleTransition

class SignUp2ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate{

    var email:String!
    var fullName:String!
    let segueID = "school"
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var next: UIBarButtonItem!
    
    let transition = BubbleTransition()
    let tapRect = UITapGestureRecognizer()
    
    
    override func viewWillLayoutSubviews() {
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.borderWidth = 2
        profileImage.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        username.delegate = self
        password.delegate = self
        verifyPassword.delegate = self
        transition.duration = 0.4
        
        // add tap to profileImage
        tapRect.addTarget(self, action:"addImage:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        profileImage.userInteractionEnabled = true
        profileImage.addGestureRecognizer(tapRect)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        username.resignFirstResponder()
        password.resignFirstResponder()
        verifyPassword.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // func thata fires with tappig on profile image
    func addImage(sender: UITapGestureRecognizer) {
        
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

                        self.profileImage.image = finalResult
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
        
        profileImage.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func nextBtn(sender: AnyObject) {
        
        let placeholder = UIImage(named: "placeholder")
        
        if username.text != "" && password.text != "" && verifyPassword != "" && profileImage.image != placeholder && password.text == verifyPassword.text {
            
                 self.performSegueWithIdentifier(self.segueID, sender: self)
            
        }else if username.text == "" && password.text == "" && verifyPassword.text == "" && profileImage.image == placeholder {
            
            SweetAlert().showAlert(":(", subTitle: "One or More Fields Are Empty", style: AlertStyle.Error)
            
        }else if profileImage.image == placeholder {
            
             SweetAlert().showAlert("Choose a Picture", subTitle: ":(", style: AlertStyle.Error)
            
        }else if username.text == "" {
            
            SweetAlert().showAlert("Choose a User Name", subTitle: ":(", style: AlertStyle.Error)
            
        }else if password.text == "" && verifyPassword.text == "" {
            
            SweetAlert().showAlert("Choose a Password", subTitle: ":(", style: AlertStyle.Error)
            
        }else if password.text != verifyPassword.text {
            
           SweetAlert().showAlert("Passwords Don't Match", subTitle: ":(", style: AlertStyle.Error)
            
            print("passwords don't match")
        }
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == segueID {
            
            let controller = segue.destinationViewController as! SignUp3ViewController
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
            
            controller.fullName = fullName
            controller.email = email
            controller.username = username.text
            controller.password = password.text
            controller.image = profileImage.image
            
        }
        
    }
    

}
