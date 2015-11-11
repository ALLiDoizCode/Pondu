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
    
    func userQuery(){
        let query = PFUser.query()
        var userData:[user] = []
        var theUser:user!
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Bios.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        let userID = object.objectId
                        let bio = object.objectForKey("Bio") as! String!
                        let fullName = object.objectForKey("FullName") as! String!
                        let userName = object.objectForKey("username") as! String!
                        let area = object.objectForKey("Area") as! String!
                        let phone = object.objectForKey("Phone") as! String!
                        let story = object.objectForKey("Stories") as! PFFile!
                        let photo = object.objectForKey("photo") as! PFFile!
                            
                        if let userBio = bio {
                            
                            theUser = user(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: userBio, thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!)
                            
                                userData.append(theUser)
                        }else{
                            
                             theUser = user(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: "", thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!)
                            
                                userData.append(theUser)
                        }
                        
                        
                        
                    }
                    
                   
                    
                    SwiftEventBus.post("User", sender: userData)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}
