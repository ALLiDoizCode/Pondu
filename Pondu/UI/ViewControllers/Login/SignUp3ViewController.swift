//
//  SignUp3ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import ImagePickerSheetController
import Photos
import SwiftSpinner
import SwiftEventBus
import BubbleTransition

class SignUp3ViewController: UIViewController,UIViewControllerTransitioningDelegate,UITextFieldDelegate,UINavigationControllerDelegate{
    
    let segueID = "Home"
    
    let newAccount = SignUP()
    let transition = BubbleTransition()
    
    var username:String!
    var password:String!
    var email:String!
    var fullName:String!
    var image:UIImage!

  
    @IBOutlet weak var graduation: UITextField!
    @IBOutlet weak var next: UIButton!
    
    @IBAction func nextBtn(sender: AnyObject) {
        
        createUser()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.duration = 0.4
        
        graduation.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        graduation.resignFirstResponder()
       
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createUser(){
        
        let placeholder = UIImage(named: "placeholder")
        
        SwiftEventBus.onMainThread(self, name: "SignUpSucess") { (result) -> Void in
            
            SwiftSpinner.hide({
                
                self.performSegueWithIdentifier(self.segueID, sender: self)
                
            })
        }
        
        if graduation.text != "" {
            
            SwiftSpinner.show("Uploading Image...")
            
            newAccount.AccounSetup("",fullName:fullName,userName:username,password:password,Bio:"",email:email,phone:"",photo:image!,stories:image!,theYear:graduation.text!)
            
            print(username)
            print(password)
            print(email)
            print(fullName)
    }
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
        
        if segue.identifier == segueID {
            
            let controller = segue.destinationViewController
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
            
        }
        
    }
    

}
