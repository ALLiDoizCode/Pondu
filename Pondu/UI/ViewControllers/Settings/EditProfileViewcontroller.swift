//
//  EditProfileVC.swift
//  Pondu
//
//  Created by Jonathan Green on 5/22/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import Cartography
import ImagePickerSheetController
import Photos
import SwiftSpinner

class EditProfileViewcontroller: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate {
    
    let presenter = theUser()
    var currentImage:UIImage!
    var topView:UIView!
    var bottomView:UIView!
    var profileImage:UIImageView!
    
    var cancle:MaterialButton!
    var save:MaterialButton!
    var changeProfileImage:MaterialButton!
    var resetPassword:MaterialButton!
    
    var currentTitle:UILabel!
    var bioLbl:MaterialLabel!
    
    var fullName:UITextField!
    var username:UITextField!
    var email:UITextField!
    var phoneNumber:UITextField!
    var bio:TextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancle = MaterialButton()
        save = MaterialButton()
        changeProfileImage = MaterialButton()
        resetPassword = MaterialButton()
        topView = UIView()
        bottomView = UIView()
        currentTitle = UILabel()
        
        fullName = UITextField()
        username = UITextField()
        email = UITextField()
        phoneNumber = UITextField()
        
        bio = TextView()
        bioLbl = MaterialLabel()
        
        makeViews()
        makeTextFields()
        makeBtns()
        makeLbls()

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

    
    func addImage() {
        
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
                    self.currentImage = finalResult
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
                    
                    self.profileImage.image = finalResult
                    self.currentImage = finalResult
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
    
    func saveChange(){
        
        if fullName.text == "" && username.text == "" && email.text == "" && phoneNumber.text == "" && bio.text == "" && currentImage == nil {
            
            print("At least one field needs to be changed")
            
        }else {
            
            self.startSpin()
            
            presenter.saveChanges(fullName.text, userName: username.text, email: email.text, phone: phoneNumber.text, profileImage: currentImage, bio: bio.text) { (result) in
                
                if result == true {
                    
                    print("changes saved")
                    
                    self.stopSpin()
                    
                }else {
                    
                    self.stopSpin()
                    
                    print("there was an issue saving the changes")
                }
            }
        }
        
    }
    
    func resetPass() {
        
        presenter.resetPassWord { (result) in
            
            if result == true {
                
                let alert = UIAlertController(title: "Instructions Have Been Sent To Your Email", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
              
                alert.addAction(OK)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func makeViews() {
       
        topView.backgroundColor = MaterialColor.white
        self.view.addSubview(topView)
        bottomView.backgroundColor = MaterialColor.grey.lighten2
        self.view.addSubview(bottomView)
        
        constrain(topView,bottomView){ topView, bottomView in
            
            topView.top == topView.superview!.top
            topView.width == topView.superview!.width
            topView.height == (topView.superview?.height)! * (1/3)
            
            bottomView.bottom == bottomView.superview!.bottom
            bottomView.width == bottomView.superview!.width
            bottomView.height == (bottomView.superview?.height)! * (2/3)
        }
        
        profileImage = UIImageView()
        profileImage.image = UIImage(named: "bike")
        profileImage.contentMode = .ScaleAspectFill
        topView.addSubview(profileImage)
        topView.addSubview(cancle)
        topView.addSubview(save)
        topView.addSubview(changeProfileImage)
        topView.addSubview(currentTitle)
    
        dispatch_async(dispatch_get_main_queue()) {
            
            self.profileImage.layer.cornerRadius = self.profileImage.layer.frame.height/2
            self.profileImage.layer.masksToBounds = true

        }
        
        constrain(profileImage){ profileImage in
            
            profileImage.height == (profileImage.superview?.height)! * 0.6
            profileImage.width == (profileImage.superview?.height)! * 0.6
            profileImage.center == (profileImage.superview?.center)!
        
        }
        
    }
    
    func makeTextFields(){
        
        bottomView.addSubview(fullName)
        bottomView.addSubview(username)
        bottomView.addSubview(email)
        bottomView.addSubview(phoneNumber)
        bottomView.addSubview(resetPassword)
        bottomView.addSubview(bio)
        bottomView.addSubview(bioLbl)
        
        fullName.font = UIFont(name: "Optima", size: 14)
        fullName.placeholder = " Full Name"
        fullName.layer.borderWidth = 1
        fullName.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        fullName.backgroundColor = MaterialColor.white
        
        username.placeholder = " Username"
        username.layer.borderWidth = 1
        username.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        username.font = UIFont(name: "Optima", size: 14)
        username.backgroundColor = MaterialColor.white
        
        email.placeholder = " Email"
        email.layer.borderWidth = 1
        email.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        email.font = UIFont(name: "Optima", size: 14)
        email.backgroundColor = MaterialColor.white
        
        phoneNumber.placeholder = " Phone Number"
        phoneNumber.textAlignment = .Center
        phoneNumber.layer.borderWidth = 1
        phoneNumber.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        phoneNumber.font = UIFont(name: "Optima", size: 14)
        phoneNumber.backgroundColor = MaterialColor.white
        
        bio.placeholderLabel?.text = "Bio"
        bio.textAlignment = .Center
        bio.layer.borderWidth = 1
        bio.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        bio.font = UIFont(name: "Optima", size: 14)
        bio.backgroundColor = MaterialColor.white
        bio.textColor = MaterialColor.grey.lighten1
        bio.clipsToBounds = true
        
        bioLbl.text = "Bio"
        bioLbl.textColor = MaterialColor.grey.lighten1
        
        constrain(fullName,username,email,phoneNumber) { fullName,username,email,phoneNumber in
            
            fullName.width == (fullName.superview?.width)! * 0.944
            fullName.height == (fullName.superview?.height)! * 0.08
            fullName.top  == fullName.superview!.top + 21
            fullName.left == fullName.superview!.left + 10
            
            username.left == (username.superview?.left)! + 10
            username.top == fullName.bottom + 20
            username.width == (username.superview?.width)! * 0.944
            username.height == (username.superview?.height)! * 0.08
            
            email.left == (email.superview?.left)! + 10
            email.top == username.bottom + 20
            email.width == (email.superview?.width)! * 0.944
            email.height == (email.superview?.height)! * 0.08
            
            phoneNumber.centerX == (phoneNumber.superview?.centerX)!
            phoneNumber.width == (phoneNumber.superview?.width)! * 0.70
            phoneNumber.top == email.bottom + 20
            phoneNumber.height == (phoneNumber.superview?.height)! * 0.08

        }
        
        constrain(resetPassword,phoneNumber,bio,bioLbl) { (resetPassword,phoneNumber,bio,bioLbl) in
            
            resetPassword.width == (resetPassword.superview?.width)! * 0.42
            resetPassword.height == (resetPassword.superview?.height)! * 0.08
            resetPassword.top == phoneNumber.bottom + 20
            resetPassword.centerX == resetPassword.superview!.centerX

            bio.width == (bio.superview?.width)! * 0.944
            bio.height == (bio.superview?.height)! * 0.25
            bio.bottom == (bio.superview?.bottom)! - 10
            bio.left == bio.superview!.left + 10
            
            bioLbl.width == 30
            bioLbl.left == bioLbl.superview!.left + 10
            bioLbl.bottom == bio.top
        }
    }
    
    func makeBtns(){
        
        resetPassword.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        resetPassword.cornerRadiusPreset = .Radius2
        resetPassword.setTitle("Reset Password", forState: UIControlState.Normal)
        resetPassword.addTarget(self, action: "resetPass", forControlEvents: UIControlEvents.TouchUpInside)
        
        cancle.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        cancle.cornerRadiusPreset = .Radius2
        cancle.setTitle("Cancle", forState: UIControlState.Normal)

        save.setTitleColor(MaterialColor.purple.lighten3, forState: UIControlState.Normal)
        save.cornerRadiusPreset = .Radius2
        save.setTitle("Save", forState: UIControlState.Normal)
        save.addTarget(self, action: "saveChange", forControlEvents: UIControlEvents.TouchUpInside)
        
        changeProfileImage.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        changeProfileImage.cornerRadiusPreset = .Radius2
        changeProfileImage.setTitle("Change Profile Image", forState: UIControlState.Normal)
        changeProfileImage.addTarget(self, action: "addImage", forControlEvents: UIControlEvents.TouchUpInside)
        
        constrain(cancle,save,changeProfileImage) { cancle,save,changeProfileImage in
            
            cancle.top  == cancle.superview!.top + 5
            cancle.left == cancle.superview!.left + 10
            
            save.right == (save.superview?.right)! - 10
            save.top  == save.superview!.top + 5
            
            changeProfileImage.bottom == (changeProfileImage.superview?.bottom)! - 10
            changeProfileImage.centerX == (changeProfileImage.superview?.centerX)!
        }
    }
    
    func makeLbls(){
        
        currentTitle.text = "Edit Profile"
        currentTitle.font = UIFont(name: "Optima", size: 14)
        constrain(currentTitle) { currentTitle in
            
            currentTitle.top == (currentTitle.superview?.top)! + 10
            currentTitle.centerX == (currentTitle.superview?.centerX)!
        }
    }
}
