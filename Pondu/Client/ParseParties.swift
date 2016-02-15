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
    
    func postQuery(favId:[String]?){
        
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
                            print("number of favorites \(favId?.count)")
                            
                            
                            // Do something with the found objects
                            if let objects = objects {
                                for object in objects {
                                    print(object.objectId)
                                    
                                    let theID = object.objectId
                                    let post = object.objectForKey("Post") as! String!
                                    //let eventImages = object.objectForKey("EventImages") as! PFFile!
                                    //let likes = object.objectForKey("Likes") as! Int!
                                    let profileName = object.objectForKey("Name") as! String!
                                    //let theAddress = object.objectForKey("Location") as! String!
                                    //let video = object.objectForKey("Video") as! PFFile!
                                    //let live = object.objectForKey("Live") as! Bool!
                                    //let privacy = object.objectForKey("Privacy") as! Bool!
                                    let createdBy = object.objectForKey("CreatedBy") as! PFObject
                                    let profileImage = createdBy.objectForKey("photo") as! PFFile
                                    
                                    print(post)
                                    
                                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!)
                                    
                                    wall.append(theEvent)
                                    
                                    
                                }
                                
                                
                                
                                SwiftEventBus.post("PartyEvent", sender: wall)
                                //SwiftEventBus.post("FavoritesList", sender: wall)
                                
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