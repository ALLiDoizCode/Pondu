//
//  SignUp1ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController {

    
    let segueID = "next"
    
    @IBOutlet weak var next: UIButton!
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
    
    
    @IBAction func nextBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier(segueID, sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
