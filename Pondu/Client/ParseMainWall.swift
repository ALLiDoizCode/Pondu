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
    
            func postQuery(){
                
                var eventPost:[String] = []
                
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) names.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                
                                let post = object.objectForKey("Post") as! String
                                //print(name)
                                
                                eventPost.append(post)
                            }
                            
                            SwiftEventBus.post("MainWallEvent", sender: eventPost)
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }
    
            func ImageQuery(){
                
                var eventProfileImage:[String] = []
                
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) names.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                
                                let profileImage = object.objectForKey("ProfilePicture") as! PFFile
                                
                                
                                eventProfileImage.append(profileImage.url!)
                            }
                            
                            SwiftEventBus.post("MainWallImage", sender: eventProfileImage)
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }

        
            }
    
    func likesQuery(){
        
        var eventLikes:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) names.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        let Likes = object.objectForKey("Likes") as! String
                        //print(name)
                        
                        eventLikes.append(Likes)
                    }
                    
                    SwiftEventBus.post("MainWallLikes", sender: eventLikes)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func commentsQuery(){
        
        var eventComments:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) names.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        let Comments = object.objectForKey("Comments") as! String
                        //print(name)
                        
                        eventComments.append(Comments)
                    }
                    
                    SwiftEventBus.post("MainWallComments", sender: eventComments)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func profileNameQuery(){
        
        var eventprofileName:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) names.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        let profileName = object.objectForKey("Name") as! String
                        //print(name)
                        
                        eventprofileName.append(profileName)
                    }
                    
                    SwiftEventBus.post("MainWallProfileName", sender: eventprofileName)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

}

