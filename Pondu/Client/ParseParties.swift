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
    
    var partyMainWallID:[String] = []
    var currentUser = PFUser.currentUser()
    
    func postQuery(){
        
        var wall:[Event] = []
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            
            if let objects = objects {
                
                for object in objects {
                    
                    let relation = object.relationForKey("Parties")
                    let partyQuery = relation.query()
                    
                    partyQuery!.findObjectsInBackgroundWithBlock {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            print("Successfully retrieved \(objects!.count) Posts.")
                           
                            
                            
                            // Do something with the found objects
                            if let objects = objects {
                                for object in objects {
                                    print(object.objectId)
                                    
                                    let theID = object.objectId
                                    let post = object.objectForKey("Post") as! String!
                                    let profileName = object.objectForKey("Name") as! String!
                                    let createdBy = object.objectForKey("CreatedBy") as! PFObject
                                    let profileImage = createdBy.objectForKey("photo") as! PFFile
                                    
                                    print(post)
                                    
                                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!)
                                    
                                    wall.append(theEvent)
                                    
                                    
                                }
                                
                                
                                
                                SwiftEventBus.post("PartyEvent", sender: wall)
                               
                                
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
    
    func favParties(){
        
        let relation = currentUser?.relationForKey("favParties")
        let query = relation?.query()
        
        var wall:[Event] = []
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            print("boom \(objects?.count)")
            
            if let objects = objects {
                
                for object in objects {
                    
                    let party = object.objectForKey("Parties") as! PFObject
                    let theID = party.objectId
                    let post = party.objectForKey("Post") as! String!
                    let profileName = party.objectForKey("Name") as! String!
                    let createdBy = party.objectForKey("CreatedBy") as! PFObject
                    let profileImage = createdBy.objectForKey("photo") as! PFFile
                    
                    print(post)
                    print("boom\(theID)")
                    
                    print("the favparty is firing \(post)")
                    
                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!)
                    
                    wall.append(theEvent)
                    
                }
                
                SwiftEventBus.post("FavoriteParties", sender: wall)
            }
            
            
        })
        
        
    }
    
    
}