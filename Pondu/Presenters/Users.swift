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

class theUser {
    
    let user = parseUser()
    
    func userBio(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "UserBio") { result in
            
            let bio = result.object
            print(bio)
            
        }
        
        user.bioQuery()
        
    }
    
    
    func userFullName(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "UserFullName") { result in
            
            let fullName = result.object
            print(fullName)
            
        }
        
        user.fullNameQuery()
        
    }
    
    func userNames(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "UserName") { result in
            
            let userName = result.object
            print(userName)
            
        }
        
        user.userNameQuery()
        
    }
    
    func userArea(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "UserArea") { result in
            
            let area = result.object
            print(area)
            
        }
        
        user.userAreaQuery()
        
    }
    
    func userPhone(button:UIButton){
        
        SwiftEventBus.onMainThread(self, name: "UserArea") { result in
            
            let phone = result.object
            print(phone)
            
            //button.setTitle(phone, forState: UIControlState.Normal)
            
        }
        
        user.userPhoneQuery()
        
    }
    
    func userStory(){
        
        SwiftEventBus.onMainThread(self, name: "UserStory") { result in
            
            let story = result.object
            print(story)
            
            SwiftEventBus.post("updateStory", sender: story)
            
            //imageView.kf_setImageWithURL(NSURL(string: story)!)
            
        }
        
        user.storyQuery()
    }
    
    func userPhoto(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "UserPhoto") { result in
            
            let photo = result.object
            print(photo)
            
            //imageView.kf_setImageWithURL(NSURL(string: photo)!)
            
        }
        
        user.photoQuery()
    }
}
