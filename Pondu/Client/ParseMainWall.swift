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
    
    var mainWallID:[String] = []
    
    func postQuery(favId:[String]?){
        
                var wall:[Event] = []
                var liveURls:[String] = []
        
                var query = PFQuery(className: "Events")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            
            if let objects = objects {
                
                for object in objects {
                    
                    let relation = object.relationForKey("Events")
                    let eventQuery = relation.query()
                    
                    eventQuery!.findObjectsInBackgroundWithBlock {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            print("Successfully retrieved \(objects!.count) Posts.")
                            print("number of favorites \(favId?.count)")
                            
                            
                            // Do something with the found objects
                            if let objects = objects {
                                for object in objects {
                                    print(object.objectId)
                                    
                                    let theID = object.objectId
                                    let post = object.objectForKey("Post") as! String!
                                    let profileImage = object.objectForKey("ProfilePicture") as! PFFile!
                                    let eventImages = object.objectForKey("EventImages") as! PFFile!
                                    let likes = object.objectForKey("Likes") as! Int!
                                    //let comments = object.objectForKey("Comments") as! [String]!
                                    let profileName = object.objectForKey("Name") as! String!
                                    let theAddress = object.objectForKey("Location") as! String!
                                    let video = object.objectForKey("Video") as! PFFile!
                                    let live = object.objectForKey("Live") as! Bool!
                                    //let favorite = object.objectForKey("userID") as! String
                                    //let time = object.objectForKey("Time") as! String
                                    let privacy = object.objectForKey("Privacy") as! Bool!
                                    //let liveContent = object.objectForKey("LiveContent") as! [PFFile]!
                                    
                                    print(post)
                                    
                                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!)
                                    
                                    wall.append(theEvent)
                                    
                                    
                                }
                                
                                
                                
                                SwiftEventBus.post("MainWallEvent", sender: wall)
                                //SwiftEventBus.post("FavoritesList", sender: mainWall)
                                
                            } else {
                                
                                // Log details of the failure
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                        }
                    }
                    
                }
            }
            
            
        }
        
        
        
        

}

}