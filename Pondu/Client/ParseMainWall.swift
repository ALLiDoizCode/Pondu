//
//  ParseMainWall.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class ParseMainWall {
    
    func idQuery(){
        
        var eventID:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Ids.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(name)
                        
                        eventID.append(object.objectId!)
                    }
                    
                    SwiftEventBus.post("MainWallID", sender: eventID)
                    
                    SwiftEventBus.post("Favorite", sender: eventID)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    
    func postQuery(favId:[String]?){
        
                var eventPost:[String] = []
                var favPost:[String] = []
        
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) Posts.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                //print(name)
                                
                                    if let post = object.objectForKey("Post") as! String! {
                                        
                                        if let favID = favId {
                                            
                                            for var i = 0; i<favID.count; i++ {
                                                
                                                if object.objectId == favID[i] {
                                                
                                                    
                                                    print("queryID \(post)")
                                                   
                                                print("recived fav post")
                                                favPost.append(post)
                                                 print("successfully recived \(favPost.count) fav post")
                                                
                                                }
                                            }
                                            print("sending fav post")
                                            SwiftEventBus.post("FavoritesList", sender: favPost)
                                            
                                        }else{
                                            
                                            eventPost.append(post)
                                            
                                            SwiftEventBus.post("MainWallEvent", sender: eventPost)
                                        }
                                    
                                }
                                
                            }
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }
    
            func ImageQuery(favId:[String]?){
                
                var eventProfileImage:[String] = []
                var favProfileImage:[String] = []
                
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) ProfileImages.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                
                                
                                //let profileImage:PFFile!
                                
                                if let profileImage = object.objectForKey("ProfilePicture") as! PFFile! {
                                    
                                    if let favID = favId {
                                        
                                        print("favID not nil")
                                        print(favID.count)
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                if object.objectId == favID[i] {
                                                    
                                                    print("queryID \(profileImage.url)")
                                                    
                                                    print("recived fav Image")
                                                    
                                                    if let favImage:PFFile! = profileImage {
                                                        
                                                        favProfileImage.append(favImage.url!)
                                                        print("successfully recived \(favProfileImage.count) fav Image")
                                                    }
                                                    
                                                    print("sending fav image")
                                                    print(favProfileImage.count)
                                                    SwiftEventBus.post("favImage", sender: favProfileImage)
                                                }
                                                
                                                
                                            }
                                
                                        }
                                        
                                    }else{
                                        
                                        eventProfileImage.append(profileImage.url!)
                                        
                                        SwiftEventBus.post("MainWallImage", sender: eventProfileImage)
                                    }
                                    
                                 

                                }
                                
                               
                            }
                            
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }

        
            }
    
    func ThumbQuery(favId:[String]?){
        
        var eventThumbImage:[String] = []
        
        let query = PFQuery(className:"MainWall")
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
                    
                    SwiftEventBus.post("MainWallThumbImage", sender: eventThumbImage)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func likesQuery(favId:[String]?){
        
        var eventLikes:[String] = []
        
        let query = PFQuery(className:"MainWall")
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
                    
                    SwiftEventBus.post("MainWallLikes", sender: eventLikes)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func commentsQuery(favId:[String]?){
        
        var eventComments = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Comments.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let Comments = object.objectForKey("Comments") as! NSArray! {
                            
                            eventComments = Comments
                        }
                      
                    }
                    
                    SwiftEventBus.post("MainWallComments", sender: eventComments)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func profileNameQuery(favId:[String]?){
        
        var eventprofileName:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) profileNames.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileName = object.objectForKey("Name") as! String! {
                            
                            eventprofileName.append(profileName)
                            
                        }
                        
                    }
                    
                    SwiftEventBus.post("MainWallProfileName", sender: eventprofileName)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func eventAddressQuery(favId:[String]?){
        
        var address:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) address.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileName = object.objectForKey("Location") as! String! {
                            
                            address.append(profileName)
                        }
      
                        
                    }
                    
                    SwiftEventBus.post("MainWallAddress", sender: address)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func videoQuery(favId:[String]?){
        
        var eventVideo:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) videos.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let video = object.objectForKey("Video") as! PFFile! {
                            
                             eventVideo.append(video.url!)
                            
                        }
                           
                       
                    }
                    
                    SwiftEventBus.post("MainWallVideo", sender: eventVideo)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }

}

