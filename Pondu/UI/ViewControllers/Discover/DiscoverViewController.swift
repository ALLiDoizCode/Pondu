//
//  DiscoverViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 3/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit


class DiscoverViewController: UIViewController {

    @IBOutlet weak var search: UIImageView!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!

    let tapCamera = UITapGestureRecognizer()
    let tapSearch = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.userInteractionEnabled = true
        camera.userInteractionEnabled = true
        
        tapCamera.addTarget(self, action: "tappedCamera:")
        tapSearch.addTarget(self, action: "tappedSearch:")
        
        search.addGestureRecognizer(tapSearch)
        camera.addGestureRecognizer(tapCamera)

        // Do any additional setup after loading the view.
    }
    
    func tappedCamera(sender:UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier("camera", sender: self)
    }
    
    func tappedSearch(sender:UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier("search", sender: self)
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
