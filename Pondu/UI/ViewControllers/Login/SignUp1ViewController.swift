//
//  SignUp1ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullName: UITextField!
    let segueID = "next"
    
    @IBOutlet weak var next: UIButton!
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Sign Up"
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.delegate = self
        email.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextBtn(sender: AnyObject) {
        
        if email.text != "" && fullName.text != "" {
            
            self.performSegueWithIdentifier(segueID, sender: self)
        }else {
            
            print("One or more textfields is empty")
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        fullName.resignFirstResponder()
        email.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == segueID {
            
            let controller = segue.destinationViewController as! SignUp2ViewController
            
            controller.fullName = fullName.text
            controller.email = email.text
        }
    }
    

}
