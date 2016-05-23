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

class EditProfileVC: UIViewController {
    
    var topView:UIView!
    var bottomView:UIView!
    var profileImage:UIImageView!
    
    var cancle:MaterialButton!
    var save:MaterialButton!
    var changeProfileImage:MaterialButton!
    
    var currentTitle:UILabel!
    var bioLbl:MaterialLabel!
    
    var firstName:TextField!
    var lastName:TextField!
    var username:TextField!
    var email:TextField!
    var phoneNumber:TextField!
    var password:TextField!
    var password2:TextField!
    var bio:TextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancle = MaterialButton()
        save = MaterialButton()
        changeProfileImage = MaterialButton()
        topView = UIView()
        bottomView = UIView()
        currentTitle = UILabel()
        
        firstName = TextField()
        lastName = TextField()
        username = TextField()
        email = TextField()
        phoneNumber = TextField()
        password = TextField()
        password2 = TextField()
        
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
        
        bottomView.addSubview(firstName)
        bottomView.addSubview(lastName)
        bottomView.addSubview(username)
        bottomView.addSubview(email)
        bottomView.addSubview(phoneNumber)
        bottomView.addSubview(password)
        bottomView.addSubview(password2)
        bottomView.addSubview(bio)
        bottomView.addSubview(bioLbl)
        
        firstName.font = UIFont(name: "Optima", size: 14)
        firstName.placeholder = "First Name"
        firstName.placeholderActiveColor = MaterialColor.grey.lighten1
        firstName.layer.borderWidth = 1
        firstName.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        firstName.backgroundColor = MaterialColor.white
        
        lastName.placeholder = "Last Name"
        lastName.placeholderActiveColor = MaterialColor.grey.lighten1
        lastName.layer.borderWidth = 1
        lastName.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        lastName.font = UIFont(name: "Optima", size: 14)
        lastName.backgroundColor = MaterialColor.white
        
        username.placeholder = "Username"
        username.placeholderActiveColor = MaterialColor.grey.lighten1
        username.layer.borderWidth = 1
        username.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        username.font = UIFont(name: "Optima", size: 14)
        username.backgroundColor = MaterialColor.white
        
        email.placeholder = "Email"
        email.placeholderActiveColor = MaterialColor.grey.lighten1
        email.layer.borderWidth = 1
        email.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        email.font = UIFont(name: "Optima", size: 14)
        email.backgroundColor = MaterialColor.white
        
        phoneNumber.placeholder = "Phone Number"
        phoneNumber.textAlignment = .Center
        phoneNumber.placeholderActiveColor = MaterialColor.grey.lighten1
        phoneNumber.layer.borderWidth = 1
        phoneNumber.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        phoneNumber.font = UIFont(name: "Optima", size: 14)
        phoneNumber.backgroundColor = MaterialColor.white
        
        password.placeholder = "Password"
        password.placeholderActiveColor = MaterialColor.grey.lighten1
        password.secureTextEntry = true
        password.layer.borderWidth = 1
        password.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        password.font = UIFont(name: "Optima", size: 14)
        password.backgroundColor = MaterialColor.white
        
        password2.placeholder = "Password Again"
        password2.placeholderActiveColor = MaterialColor.grey.lighten1
        password2.secureTextEntry = true
        password2.layer.borderWidth = 1
        password2.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        password2.font = UIFont(name: "Optima", size: 14)
        password2.backgroundColor = MaterialColor.white
        
        bio.placeholderLabel?.text = "Bio"
        bio.textAlignment = .Center
        bio.layer.borderWidth = 1
        bio.layer.borderColor = MaterialColor.grey.lighten1.CGColor
        bio.font = UIFont(name: "Optima", size: 14)
        bio.backgroundColor = MaterialColor.white
        bio.clipsToBounds = true
        
        bioLbl.text = "Bio"
        bioLbl.textColor = MaterialColor.grey.lighten1
        
        constrain(firstName,lastName,username,email,phoneNumber) { firstName,lastName,username,email,phoneNumber in
            
            firstName.width == (firstName.superview?.width)! * 0.42
            firstName.height == (firstName.superview?.height)! * 0.08
            firstName.top  == firstName.superview!.top + 21
            firstName.left == firstName.superview!.left + 10
            
            lastName.width == (lastName.superview?.width)! * 0.42
            lastName.height == (lastName.superview?.height)! * 0.08
            lastName.top  == lastName.superview!.top + 21
            lastName.right == lastName.superview!.right - 10
            
            username.left == (username.superview?.left)! + 10
            username.top == firstName.bottom + 20
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
        
        constrain(password,password2,phoneNumber,bio,bioLbl) { (password,password2,phoneNumber,bio,bioLbl) in
            
            password.width == (password.superview?.width)! * 0.42
            password.height == (password.superview?.height)! * 0.08
            password.top == phoneNumber.bottom + 20
            password.left == password.superview!.left + 10
            
            password2.width == (password2.superview?.width)! * 0.42
            password2.height == (password2.superview?.height)! * 0.08
            password2.top == phoneNumber.bottom + 20
            password2.right == password2.superview!.right - 10
            
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
        
        cancle.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        save.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        changeProfileImage.setTitleColor(MaterialColor.grey.lighten1, forState: UIControlState.Normal)
        cancle.cornerRadiusPreset = .Radius2
        save.cornerRadiusPreset = .Radius2
        changeProfileImage.cornerRadiusPreset = .Radius2
        
        cancle.setTitle("Cancle", forState: UIControlState.Normal)
        save.setTitle("Save", forState: UIControlState.Normal)
        changeProfileImage.setTitle("Change Profile Image", forState: UIControlState.Normal)
     
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
        
        constrain(currentTitle) { currentTitle in
            
            currentTitle.top == (currentTitle.superview?.top)! + 10
            currentTitle.centerX == (currentTitle.superview?.centerX)!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
