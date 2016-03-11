//
//  ChatImageController.swift
//  Pondu
//
//  Created by Jonathan Green on 3/11/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class ChatImageController: UIViewController {

    @IBOutlet weak var theImage: UIImageView!
    
    let swipeDownRect = UISwipeGestureRecognizer()
    
    var image:String!
    var objectId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeDownRect.addTarget(self, action: "swippedDown:")
        swipeDownRect.numberOfTouchesRequired = 1
        swipeDownRect.direction = .Down
        self.view!.addGestureRecognizer(swipeDownRect)
        
        theImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: UIImage(named: "placeholder"))
        
        // Do any additional setup after loading the view.
    }
    
    func swippedDown(sender:UISwipeGestureRecognizer) {
        
        self.performSegueWithIdentifier("back", sender: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        let controller = segue.destinationViewController as! ChatViewController
        
        controller.objectId = objectId
    }


}
