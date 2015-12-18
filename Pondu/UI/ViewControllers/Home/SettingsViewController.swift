//
//  SettingsViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Parse
import BubbleTransition

class SettingsViewController: UIViewController,UIViewControllerTransitioningDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchContacts: UIButton!
    @IBOutlet weak var addFriends: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var terms: UIButton!
    @IBOutlet weak var policy: UIButton!
    @IBOutlet weak var site: UIButton!
    @IBOutlet weak var privacy: UISwitch!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var blocked: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var changePassWord: UIButton!
    
    var currentUser = PFUser.currentUser()
    let transition = BubbleTransition()
    
    override func viewWillAppear(animated: Bool) {
        
         self.navigationController?.navigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        name.delegate = self
        userName.delegate = self
        email.delegate = self
        phone.delegate = self
        bio.delegate = self
        newPass.delegate = self
        confirmPass.delegate = self
        
        transition.duration = 0.4
        
        name.hidden = true
        userName.hidden = true
        email.hidden = true
        phone.hidden = true
        bio.hidden = true
        
        newPass.hidden = true
        confirmPass.hidden = true
        
        //name.text = currentUser?.objectForKey(<#T##key: String##String#>)
        email.text = currentUser?.email
        userName.text = currentUser?.username
        //phone.text = currentUser?.objectForKey(<#T##key: String##String#>)
        //bio.text = currentUser?.objectForKey(<#T##key: String##String#>)

        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfileBtn(sender: AnyObject) {
        
        if  name.hidden == false &&
        userName.hidden == false &&
        email.hidden == false &&
        phone.hidden == false &&
        bio.hidden == false {
            
           if name.text != "" &&
                userName.text != "" &&
                email.text != "" &&
                phone.text != "" &&
                bio.text != "" {
                    
                    name.hidden = true
                    userName.hidden = true
                    email.hidden = true
                    phone.hidden = true
                    bio.hidden = true
                    //save changes
                    
            }else {
                
                // a field or more is empty
            }
        
        }else {
            
            name.hidden = false
            userName.hidden = false
            email.hidden = false
            phone.hidden = false
            bio.hidden = false

        }
        
       
    }
    
    @IBAction func changePassWordBtn(sender: AnyObject) {
        
        if newPass.hidden == false &&
        confirmPass.hidden == false {
            
            if newPass.text != "" && confirmPass.text == newPass.text {
                    
                    // save changes
                
                    newPass.hidden = true
                    confirmPass.hidden = true
                    
                    
            }else {
                
                //alert issued with new password
            }
        }else {
            
            newPass.hidden = false
            confirmPass.hidden = false
        }
    }
   
    @IBAction func addFriendsBtn(sender: AnyObject) {
    }
    @IBAction func searchContactBtn(sender: AnyObject) {
    }
    @IBAction func helpBtn(sender: AnyObject) {
    }
    @IBAction func termsBtn(sender: AnyObject) {
    }
    @IBAction func policyBtn(sender: AnyObject) {
    }
    @IBAction func siteBtn(sender: AnyObject) {
    }
    @IBAction func privacyBtn(sender: AnyObject) {
    }
    @IBAction func clearBtn(sender: AnyObject) {
    }
    @IBAction func blockedBtn(sender: AnyObject) {
    }
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        
        self.performSegueWithIdentifier("logout", sender: self)
        
    }
    @IBAction func deleteBtn(sender: AnyObject) {
        
        deleteUser()
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    func deleteUser(){
        
        currentUser?.deleteEventually()    
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.blueColor()
        return transition
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    

}
