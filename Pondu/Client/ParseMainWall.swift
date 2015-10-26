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

}

