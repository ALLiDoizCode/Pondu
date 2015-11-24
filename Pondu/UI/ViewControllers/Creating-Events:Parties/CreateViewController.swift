//
//  CreateViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/19/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel

class CreateViewController: UIViewController {

    @IBOutlet weak var mainTitle: LTMorphingLabel!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var party: UIButton!
    @IBOutlet weak var event: UIButton!
    
    var type:Bool!
    
    
    override func viewWillAppear(animated: Bool) {
        
        type = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Type"
        mainTitle.text = "What are you hosting"
        mainTitle.morphingEffect = .Evaporate
        mainTitle.morphingDuration = 0.8

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func partyBtn(sender: AnyObject) {
        
        type = true
        
        print(type)
        
        party.backgroundColor = UIColor.grayColor()
        event.backgroundColor = UIColor.clearColor()
        
    }
    
    @IBAction func eventBtn(sender: AnyObject) {
        
        type = false
        
        print(type)
        
        event.backgroundColor = UIColor.grayColor()
        party.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func nextBtn(sender: AnyObject) {
        
        if type != nil {
            
            self.performSegueWithIdentifier("Wall", sender: self)
        }else{
            
            print("post alert for no selection")
        }
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Wall" {
            
            let nextViewController:WallViewController = segue.destinationViewController as! WallViewController
            nextViewController.type = type
            
            print("passing \(type)")
        }
    
    
    }

}
