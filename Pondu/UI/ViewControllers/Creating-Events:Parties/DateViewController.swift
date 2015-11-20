//
//  DateViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/20/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel

class DateViewController: UIViewController {

    @IBOutlet weak var mainLabel: LTMorphingLabel!
    @IBOutlet weak var mainLabel2: LTMorphingLabel!
    @IBOutlet weak var mainLabel2End: LTMorphingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Date"
        
        mainLabel.text = "When is this Event"
        mainLabel.morphingEffect = .Evaporate
        mainLabel.morphingDuration = 0.8
        mainLabel.numberOfLines = 0
        
        mainLabel2.text = "What are time frames for"
        mainLabel2.morphingEffect = .Evaporate
        mainLabel2.morphingDuration = 0.8
        mainLabel2.numberOfLines = 0
        mainLabel2.clipsToBounds = true
        
        mainLabel2End.text = "this Event?"
        mainLabel2End.morphingEffect = .Evaporate
        mainLabel2End.morphingDuration = 0.8
        mainLabel2End.numberOfLines = 0
        mainLabel2End.clipsToBounds = true
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
