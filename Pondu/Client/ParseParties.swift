//
//  ParseParties.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class ParseParties {
    
    func postQuery(){
        
        var eventPost:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Posts.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let post = object.objectForKey("Posts") as! String! {
                            
                            eventPost.append(post)
                        }
                       
                    }
                    
                    SwiftEventBus.post("MainWallParties", sender: eventPost)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func ImageQuery(){
        
        var eventProfileImage:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) ProfileImages.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileImage = object.objectForKey("ProfilePicture") as! PFFile! {
                            
                            eventProfileImage.append(profileImage.url!)
                        }
                        
                    }
                    
                    SwiftEventBus.post("PartiesImage", sender: eventProfileImage)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func ThumbQuery(){
        
        var eventThumbImage:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) ProfileImages.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let ThumbImage = object.objectForKey("Mainthumb") as! PFFile! {
                            
                            eventThumbImage.append(ThumbImage.url!)
                        }
                        
                        
                    }
                    
                    SwiftEventBus.post("PartiesThumbImage", sender: eventThumbImage)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func likesQuery(){
        
        var eventLikes:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Likes.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let Likes = object.objectForKey("Likes") as! String! {
                            
                            eventLikes.append(Likes)
                        }
                        
                    }
                    
                    SwiftEventBus.post("PartiesLikes", sender: eventLikes)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func commentsQuery(){
        
        var eventComments:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Comments.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let Comments = object.objectForKey("Comments") as! String!{
                            
                            eventComments.append(Comments)
                        }
                        
                    }
                    
                    SwiftEventBus.post("PartiesComments", sender: eventComments)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func profileNameQuery(){
        
        var eventprofileName:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) profileNames.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileName = object.objectForKey("Name") as! String!{
                            
                            eventprofileName.append(profileName)
                        }
                        
                    }
                    
                    SwiftEventBus.post("PartiesProfileName", sender: eventprofileName)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func eventAddressQuery(){
        
        var address:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) address.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileName = object.objectForKey("Location") as! String!{
                            
                            address.append(profileName)
                        }
                        
                    }
                    
                    SwiftEventBus.post("PartiesAddress", sender: address)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func videoQuery(){
        
        var eventVideo:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) videos.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let video = object.objectForKey("Video") as! PFFile!{
                            
                            eventVideo.append(video.url!)
                        }
                        
                        
                       
                    }
                    
                    SwiftEventBus.post("PartiesVideo", sender: eventVideo)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
}

