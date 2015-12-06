//
//  LoginViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/5/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var login: DesignableButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(sender: AnyObject) {
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
