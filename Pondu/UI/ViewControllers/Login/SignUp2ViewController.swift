//
//  SignUp2ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController,UITextFieldDelegate {

    var email:String!
    var fullName:String!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var next: UIBarButtonItem!
    
    let newAccount = SignUP()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        username.delegate = self
        password.delegate = self
        verifyPassword.delegate = self
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
    

    @IBAction func nextBtn(sender: AnyObject) {
        
        if username.text != "" && password.text != "" && verifyPassword != "" && password.text == verifyPassword.text {
            
            let photo = UIImage(named: "bob")
            let story = UIImage(named: "story")
            
            newAccount.AccounSetup("",fullName:fullName,userName:username.text!,password:password.text!,Bio:"",email:email,phone:"",photo:photo!,stories:story!)
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
