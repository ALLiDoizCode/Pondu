//
//  SettingsViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchContacts: UIButton!
    @IBOutlet weak var addFriends: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var currentPass: UITextField!
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
    
    override func viewWillAppear(animated: Bool) {
        
         self.navigationController?.navigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    @IBAction func deleteBtn(sender: AnyObject) {
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
