//
//  LoginViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/5/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var login: DesignableButton!
    
    @IBOutlet var mainVIew: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var border: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLayoutSubviews() {

        if UIScreen.mainScreen().bounds.width == 320.0 {
            
            login.layer.frame = CGRectMake(login.frame.origin.x - 10
                , login.frame.origin.y - 5, login.frame.size.width + 10, login.frame.size.height + 10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.delegate = self
        password.delegate = self
        
        print(UIScreen.mainScreen().bounds.width)
        
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(sender: AnyObject) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
