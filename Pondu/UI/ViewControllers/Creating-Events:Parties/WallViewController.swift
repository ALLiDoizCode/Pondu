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

    @IBOutlet weak var mainTitle: LTMorphingLabel!
    @IBOutlet weak var mainTitle2: LTMorphingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Who's Coming"

        mainTitle.text = "Who's allowed to come to come to"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
