//
//  StoryViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/7/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher
import HoneycombView

class StoryViewController: UIViewController {
    
    var array:[String] = []
    var users = [User]()
    var storyUser:theUser = theUser()

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyUser.userStory()
        
        SwiftEventBus.onMainThread(self, name: "updateStory") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [String]

            for var i = 0; i < self.array.count; i++ {
                let user = User(id: i, profileImageURL: self.array[i])
                self.users.append(user)
            }
            
            let honeycombView = HoneycombView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))

            
            honeycombView.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
            honeycombView.diameter = 100
            honeycombView.margin = 5
            //honeycombView.honeycombBackgroundColor = UIColor.clearColor()
            
            
            //honeycombView.configrationForHoneycombViewWithImages(images)
            honeycombView.configrationForHoneycombViewWithURL(self.users.map{ $0.profileImageURL })
            self.view.addSubview(honeycombView)
            
            honeycombView.animate(2.0)

        }


        // Do any additional setup after loading the view.
    }

struct User {
    var id:Int!
    var profileImageURL:String!
    
    init(id:Int = 0, profileImageURL:String = "image"){
        self.id = id
        self.profileImageURL = profileImageURL
    }
    
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
