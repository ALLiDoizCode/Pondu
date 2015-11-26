//
//  LiveViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    var indexOfUrl:[Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let word = "Zebra"
        
        for i in word.characters {
            print(i)
            
            indexOfUrl.append(i)
        }
        
        print(indexOfUrl.count - 1)
        
        let letterIndex = indexOfUrl.count - 1
        
        let chac1 = indexOfUrl[letterIndex]
        let chac2 = indexOfUrl[letterIndex - 1]
        let chac3 = indexOfUrl[letterIndex - 2]
        
        let fileType = "\(chac3)\(chac2)\(chac1)"
        
        print(fileType)
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
