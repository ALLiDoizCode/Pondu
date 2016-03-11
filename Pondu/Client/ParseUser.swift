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
    
    func saveUserInfo(name:String,userName:String,email:String,phone:String,bio:String){
        
        let user = PFUser.currentUser()
        
        user!["FullName"] = name
        user!["Phone"] = phone
        user!["Bio"] = bio
        
        user?.username = userName
        user?.email = email
    
        user?.saveInBackground()
        
    }
    
    func savePassWord(email:String){
        
       PFUser.requestPasswordResetForEmailInBackground(email)
        
    }
    
    func userQuery(){
        let query = PFUser.query()
        var userInfo:[userData] = []
        //var theUser:userData!
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Bios.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        let userID = object.objectId
                        let userName = object.objectForKey("username") as! String!
                        let photo = object.objectForKey("photo") as! PFFile!
                   
                        
                        let theUser = userData(theObjectID: userID!, theArea: "", theFullName: "", theUserName: userName, thePassWord: "", theBio: "", thePhone: "", theEmail: "", theStory: "", theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!,theFav:true,theYear:"" )
                     
                        userInfo.append(theUser)
      
                        
                    }
                    
                    if userInfo.count != 0 {
                        
                        print("userInfo \(userInfo.count)")
                        
                        SwiftEventBus.post("User", sender: userInfo)
                        
                    }

                    
                    
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}
