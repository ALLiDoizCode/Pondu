//
//  ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let mainWall = PresentMainWall()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainWall.getEventDescription()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

