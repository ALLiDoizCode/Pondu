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
import Alamofire

class SignUp3ViewController: UIViewController,UIViewControllerTransitioningDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate{
    
    let segueID = "Home"
    
    let presenter = theUser()
    let transition = BubbleTransition()
    let client:college = college()
    
    var username:String!
    var password:String!
    var email:String!
    var fullName:String!
    var image:UIImage!
    
    var schools:[School] = []

    @IBOutlet weak var pickerView: UIPickerView!
  
    @IBOutlet weak var pickSchool: UIButton!
    @IBOutlet weak var graduation: UITextField!
    @IBOutlet weak var next: UIButton!
    
    @IBAction func nextBtn(sender: AnyObject) {
        
        createUser()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onMainThread(self, name:"school") { (result) -> Void in
            
            self.schools = result.object as! [School]
            
            self.pickerView.reloadAllComponents()
            
        }
        
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 4
        let currentString: NSString = textField.text!
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickSchoolBtn(sender: AnyObject) {
        
        
        self.schools = []
        
        self.pickerView.reloadAllComponents()

        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Search",
            message: "Entered Shool Name",
            preferredStyle: .Alert)
        
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "School Name"
        })
        
        let action = UIAlertAction(title: "Search",
            style: UIAlertActionStyle.Default,
            handler: {[weak self]
                (paramAction:UIAlertAction!) in
                if let textFields = alertController?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let enteredText = theTextFields[0].text
                    let newString = enteredText!.stringByReplacingOccurrencesOfString(" ", withString: "_")

                    self!.client.getData(newString)
                    print("Entered Shool Name \(newString)")
                    
                    //self!.displayLabel.text = enteredText
                }
            })
        
        
    
        alertController?.addAction(action)
        self.presentViewController(alertController!,
            animated: true,completion:{
                
                
        })
        
        if schools.count > 0 {
            
            self.pickerView.reloadAllComponents()
            
        }
    }
    

    
    func createUser(){
        
        if graduation.text != "" && pickSchool.titleLabel?.text != "Pick Your School"  {
            
            SwiftSpinner.show("A verification link has been sent to your email...")
            
            print(username)
            print(password)
            print(email)
            print(fullName)
            print(pickSchool.titleLabel?.text)
            
            
            presenter.signUp(fullName, userName: username, passWord: password, email: email, profileImage: image, completion: { (success) -> Void in
                
                if success == true {
                    
                    SwiftSpinner.hide({
                        
                        self.performSegueWithIdentifier(self.segueID, sender: self)
                        
                    })
                    
                }else {
                    
                    SweetAlert().showAlert("There was an issue Creating an Account", subTitle: ":(", style: AlertStyle.Error)
                }
            })
            
        }else if pickSchool.titleLabel?.text == "Pick Your School" {
            
             SweetAlert().showAlert("Pick a School", subTitle: ":(", style: AlertStyle.Error)
            
        }else if graduation.text == "" {
            
            SweetAlert().showAlert("Enter Graduation Date", subTitle: ":(", style: AlertStyle.Error)
        }
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return schools.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       
        if schools.count > 0 {
            
            return schools[row].name
            
        }else {
            
             return ""
        }

    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if schools.count > 0 {
            
            pickSchool.setTitle(schools[row].name, forState: UIControlState.Normal)
            
        }else {
            
            SweetAlert().showAlert(":(", subTitle: "Sorry We Can't Find Your School", style: AlertStyle.Error)
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
