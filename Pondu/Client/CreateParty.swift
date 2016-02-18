//
//  CreateParty.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse


class createParty {
    
    func theParty(){
        
        let wall = PFObject(className: "MainWall")
        let comments = PFObject(className: "CommentTable")
        let liveContent = PFObject(className: "LiveContentTable")
        let party = PFObject(withoutDataWithClassName: "Parties", objectId: "F4NvBwtn3v")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "makeParty") { result in
            
            let createdParty = result.object as! makeParty
            
            wall["CreatedBy"] = currentUser
            wall["Post"] = createdParty.post
            wall["Name"] = currentUser?.username
            wall["Live"] = createdParty.live
            wall["Likes"] = 0
            wall["Privacy"] = createdParty.privacy
            
            wall.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    let relation = party.relationForKey("Parties")
                    relation.addObject(wall)
                    
                    party.saveInBackgroundWithBlock({ (sucess:Bool, error:NSError?) -> Void in
                        
                        if success {
                            
                            print("wall ID is \(wall.objectId)")
                            
                            comments["CreatedBy"] = wall
                            
                            comments.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                
                                if success {
                                    
                                    print("comments ID is \(comments.objectId)")
                                    
                                    wall["Comments"] = comments
                                    
                                    wall.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                        
                                        if success {
                                            
                                            print("event made")
                                            
                                            SwiftEventBus.post("EventMade")
                                        }
                                    })
                                }
                                
                            })
                        }
                        
                    })
                    
                    print("event made")
                    
                    SwiftEventBus.post("EventMade")
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the event")
                    SwiftEventBus.post("EventNotMade")
                }
            }
        }
        
        
    }

}

