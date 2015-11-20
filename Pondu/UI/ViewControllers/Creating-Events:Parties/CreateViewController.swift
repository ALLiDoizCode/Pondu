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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
