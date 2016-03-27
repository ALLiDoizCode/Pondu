//
//  WelcomeViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel
import FXBlurView

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var topLabel: LTMorphingLabel!
    @IBOutlet weak var bottomLabel: LTMorphingLabel!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var bottemView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        
        
        topLabel.text = "Welcome"
        topLabel.morphingEffect = .Evaporate
        topLabel.morphingDuration = 1
        
        bottomLabel.text = "To Pondu."
        bottomLabel.morphingEffect = .Evaporate
        bottomLabel.morphingDuration = 1
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bg.image = bg.image?.blurredImageWithRadius(20, iterations: 15, tintColor: UIColor.blackColor())
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
