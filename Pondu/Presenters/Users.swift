//
//  Users.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class users {
    
    let user = parseUser()
    
    func userBio(label: UILabel){
        
        
        var bio:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserBio") { result in
            
            bio = result.object![0] as! String
            print(bio)
            
            label.text = bio
            
        }
        
        user.bioQuery()
        
    }
    
    
    func userStory(imageView:UIImageView){
        
        var story:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserStory") { result in
            
            story = result.object![0] as! String
            print(story)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            imageView.kf_setImageWithURL(NSURL(string: story)!)
            
        }
        
        user.storyQuery()
    }
}
