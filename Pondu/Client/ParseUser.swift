//
//  ParseUser.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class parseUser {
    
    func bioQuery(){
        let query = PFUser.query()
        var userBio:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Bios.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let bio = object.objectForKey("Bio") as! String! {
                            
                            userBio.append(bio)
                        }
                        
                    }
                    
                    SwiftEventBus.post("UserBio", sender: userBio)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func fullNameQuery(){
        
        let query = PFUser.query()
        var userFullName:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) fullNames.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let fullName = object.objectForKey("FullName") as! String! {
                            
                             userFullName.append(fullName)
                        }
                       
                    }
                    
                    SwiftEventBus.post("UserFullName", sender: userFullName)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func userNameQuery(){
        
        let query = PFUser.query()
        var userNames:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) userNames.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let userName = object.objectForKey("username") as! String! {
                            
                            userNames.append(userName)
                        }
                        
                    }
                    
                    SwiftEventBus.post("UserName", sender: userNames)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func userAreaQuery(){
        
        let query = PFUser.query()
        var userArea:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) userAreas.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let area = object.objectForKey("Area") as! String! {
                            
                            userArea.append(area)
                        }
                        
                    }
                    
                    SwiftEventBus.post("UserArea", sender: userArea)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func userPhoneQuery(){
        
        let query = PFUser.query()
        var userPhone:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) userAreas.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let phone = object.objectForKey("Area") as! String! {
                            
                            userPhone.append(phone)
                        }
                        
                    }
                    
                    SwiftEventBus.post("UserPhone", sender: userPhone)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func storyQuery(){
        let query = PFUser.query()
        var userStory:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Story Images.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let story = object.objectForKey("Stories") as! PFFile! {
                            
                            userStory.append(story.url!)
                            print(story.url!)
                        }
                        
                    }
                    
                    print("number of stories is \(userStory.count)")
                    
                    SwiftEventBus.post("UserStory", sender: userStory)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func photoQuery(){
        let query = PFUser.query()
        var userPhoto:[String] = []
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Users photos.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let photo = object.objectForKey("photo") as! PFFile! {
                            
                            userPhoto.append(photo.url!)
                        }
                        
                    }
                    
                    SwiftEventBus.post("UserPhoto", sender: userPhoto)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
}
