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
    
    
    func userFullName(label: UILabel){
        
        
        var fullName:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserFullName") { result in
            
            fullName = result.object![0] as! String
            print(fullName)
            
            label.text = fullName
            
        }
        
        user.fullNameQuery()
        
    }
    
    func userNames(label: UILabel){
        
        
        var userName:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserName") { result in
            
            userName = result.object![0] as! String
            print(userName)
            
            label.text = userName
            
        }
        
        user.userNameQuery()
        
    }
    
    func userArea(label: UILabel){
        
        
        var area:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserArea") { result in
            
            area = result.object![0] as! String
            print(area)
            
            label.text = area
            
        }
        
        user.userAreaQuery()
        
    }
    
    func userPhone(button:UIButton){
        
        
        var phone:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserArea") { result in
            
            phone = result.object![0] as! String
            print(phone)
            
            button.setTitle(phone, forState: UIControlState.Normal)
            
        }
        
        user.userPhoneQuery()
        
    }
    
    func userStory(imageView:UIImageView){
        
        var story:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserStory") { result in
            
            story = result.object![0] as! String
            print(story)
            
            imageView.kf_setImageWithURL(NSURL(string: story)!)
            
        }
        
        user.storyQuery()
    }
    
    func userPhoto(imageView:UIImageView){
        
        var photo:String = String()
        
        SwiftEventBus.onMainThread(self, name: "UserPhoto") { result in
            
            photo = result.object![1] as! String
            print(photo)
            
            imageView.kf_setImageWithURL(NSURL(string: photo)!)
            
        }
        
        user.photoQuery()
    }
}
