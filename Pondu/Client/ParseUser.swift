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
    
    let currentUser = PFUser.currentUser()
    
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
        
        query?.whereKey("objectId", notEqualTo: (currentUser?.objectId)!)
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
                   
                        
                        let theUser = userData(theObjectID: userID!, theArea: "", theFullName: "", theUserName: userName, thePassWord: "", theBio: "", thePhone: "", theEmail: "", theStory: "", thePhoto: photo.url!,theFav:true,theYear:"" )
                     
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
    
    func follow(objectId:String){
        
        let query = PFUser.query()
        var user:PFUser!
        
        do {
            
            user = try query?.getObjectWithId(objectId) as! PFUser
            
        }catch _{
            
        }
        
        let relation = currentUser?.relationForKey("Following")
        
        relation?.addObject(user)
        
        currentUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
            
            if success == true {
                
                print("user added to favorites")
                
                SwiftEventBus.post("addUser", sender: success)
                
            }else {
                
                print("user was not added to favorites")
            }
        })
    }
    
    func myFollow(){
        
        var following:[String] = []
        
        let relation = currentUser?.relationForKey("Following")
        
        let relationQuery = relation?.query()
        
        relationQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            guard (objects != nil) else {
                
                return
            }
            
            for object in objects! {
                
                let objectId = object.objectId
                
                following.append(objectId!)
            }
            
            SwiftEventBus.post("myFollow", sender: following)
            
        })
    }
}
