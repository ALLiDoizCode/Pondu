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
    
    func userQuery(favId:[String]?){
        let query = PFUser.query()
        var userInfo:[userData] = []
        var theUser:userData!
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
                        
                        if let favID = favId {
                            
                            for var i = 0; i<objects.count; i++ {

                                if i < favID.count {
                                    
                                    if let userBio = bio {
                                        
                                        theUser = userData(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: userBio, thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!,theFav:true)
                                        
                                         print("there are \(favID.count) fav ids")
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(theUser)")
                                            print("recived fav post")
                                            userInfo.append(theUser)
                                            print("successfully recived \(userInfo.count) fav post")
                                            print("sending fav post")
                                            
                                            
                                        }
                                        
                                    }else{
                                        
                                        theUser = userData(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: "", thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!,theFav:true)
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(theUser)")
                                            print("recived fav post")
                                            userInfo.append(theUser)
                                            print("successfully recived \(userInfo.count) fav post")
                                            print("sending fav post")
                                            
                                            
                                        }
                                        
                                      
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                            
                        }else{
                            
                            if let userBio = bio {
                                
                                theUser = userData(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: userBio, thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!,theFav:false)
                                
                                
                                    print("queryID \(theUser)")
                                    print("recived fav post")
                                    userInfo.append(theUser)
                                    print("successfully recived \(userInfo.count) fav post")
                                    print("sending fav post")
                                    
                                    
                                
                                
                            }else{
                                
                                theUser = userData(theObjectID: userID!, theArea: area, theFullName: fullName, theUserName: userName, thePassWord: "", theBio: "", thePhone: phone, theEmail: "", theStory: story.url!, theFavorites: [""], thePartyFavorites: [""], thePhoto: photo.url!,theFav:false)
                                
                                    print("queryID \(theUser)")
                                    print("recived fav post")
                                    userInfo.append(theUser)
                                    print("successfully recived \(userInfo.count) fav post")
                                    print("sending fav post")
                                
                            }
                        }
      
                        
                    }
                    
                    if userInfo.count >= 1 {
                        
                        if userInfo[0].fav == true {
                            print("fav count \(userInfo.count)")
                            SwiftEventBus.post("FavUser", sender: userInfo)
                            
                        }else {
                            

                            print("userInfo count \(userInfo.count)")
                            SwiftEventBus.post("User", sender: userInfo)
                        }
                    }else{
                        
                        print("you have no favorites")
                    }

                    
                    
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}
