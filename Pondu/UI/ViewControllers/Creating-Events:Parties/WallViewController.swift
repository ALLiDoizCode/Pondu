//
//  WallViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/19/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel

class WallViewController: UIViewController {
    
    

    @IBOutlet weak var mainWall: UIButton!
    @IBOutlet weak var favoriteWall: UIButton!
    @IBOutlet weak var mainTitle: LTMorphingLabel!
    @IBOutlet weak var mainTitle2: LTMorphingLabel!
    var type:Bool!
    var privacy:Bool!
    
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Who's Coming"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       print("retrieved \(type)")
        
        self.title = "Who's Coming"

        mainTitle.text = "Who's allowed to come to"
        mainTitle.morphingEffect = .Evaporate
        mainTitle.morphingDuration = 0.8
        mainTitle.numberOfLines = 0
        
        mainTitle2.text = "this Event?"
        mainTitle2.morphingEffect = .Evaporate
        mainTitle2.morphingDuration = 0.8
        mainTitle2.numberOfLines = 0
        mainTitle2.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextButton(sender: AnyObject) {
        
        if privacy != nil {
            
            self.performSegueWithIdentifier("Date", sender: self)
            
            self.title = "Coming"
        }else{
            
            print("post alert for no selection")
        }
        
        
    }
    @IBAction func mainwallBtn(sender: AnyObject) {
        
        privacy = false
        
        mainWall.backgroundColor = UIColor.darkGrayColor()
        mainWall.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        favoriteWall.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        favoriteWall.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func favoriteWallBtn(sender: AnyObject) {
        
        privacy = true
        
        favoriteWall.backgroundColor = UIColor.darkGrayColor()
        favoriteWall.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        mainWall.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        mainWall.backgroundColor = UIColor.clearColor()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Date" {
            
            let nextViewController:DateViewController = segue.destinationViewController as! DateViewController
            
            nextViewController.type = type
            nextViewController.privacy = privacy
            
            print("passing \(type)")
            print("passing \(privacy)")

        }
        
    }
    

}
