//
//  LoginViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/5/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import BubbleTransition

class LoginViewController: UIViewController,UITextFieldDelegate,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var login: DesignableButton!
    @IBOutlet var mainVIew: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var border: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let presenter = theUser()
    let transition = BubbleTransition()
    
    let mainSegue = "Login"
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {

        if UIScreen.mainScreen().bounds.width == 320.0 {
            
            login.layer.frame = CGRectMake(login.frame.origin.x - 10
                , login.frame.origin.y - 5, login.frame.size.width + 10, login.frame.size.height + 10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.duration = 0.4
        
        username.delegate = self
        password.delegate = self
        
        print(UIScreen.mainScreen().bounds.width)
        
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(sender: AnyObject) {
        
        guard (username.text != nil) else {
            
            SweetAlert().showAlert("Wrong Password or Email", subTitle: ":(", style: AlertStyle.Error)
            
            return
        }
        
        guard (password.text != nil) else {
            
            SweetAlert().showAlert("Wrong Password or Email", subTitle: ":(", style: AlertStyle.Error)
            
            return
        }
        
        presenter.login(username.text!, passWord: password.text!) { (success) -> Void in
            
            if success == true {
                
                self.performSegueWithIdentifier(self.mainSegue, sender: self)
                
            }else {
                
                print("login failed")
                SweetAlert().showAlert("Wrong Password or Email", subTitle: ":(", style: AlertStyle.Error)
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        return true
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == mainSegue {
            
            let controller = segue.destinationViewController
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
                        
        }
    }

}
