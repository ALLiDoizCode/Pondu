//
//  CreateEvent.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//


import UIKit
import SwiftEventBus
import Parse


class createEvent {
    
    func theEvent(){
        
        let wall = PFObject(className: "MainWall")
        let comments = PFObject(className: "CommentTable")
        let liveContent = PFObject(className: "LiveContentTable")
        let event = PFObject(withoutDataWithClassName: "Events", objectId: "gUHWW0VeZD")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "makeEvent") { result in
            
            let createdEvent = result.object as! makeEvent
            
            wall["CreatedBy"] = currentUser
            wall["Post"] = createdEvent.post
            wall["Name"] = createdEvent.name
            wall["Live"] = createdEvent.live
            wall["Likes"] = 0
            wall["Privacy"] = createdEvent.privacy

            wall.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    
                    let relation = event.relationForKey("Events")
                    relation.addObject(wall)
                    
                    event.saveInBackgroundWithBlock({ (sucess:Bool, error:NSError?) -> Void in
                        
                        if success {
                            
                            print("wall ID is \(wall.objectId)")
                            
                            comments["CreatedBy"] = wall
                            liveContent["CreatedBy"] = wall
                            
                            
                            comments.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                
                                if success {
                                    
                                    print("comments ID is \(comments.objectId)")
                                    
                                    wall["Comments"] = comments
                                    
                                    
                                    liveContent.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                        
                                        if success {
                                            
                                            print("liveContent ID is \(liveContent.objectId)")
                                            
                                            wall["LiveContent"] = liveContent
                                            
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
                        }
                        
                    })
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the event")
                    SwiftEventBus.post("EventNotMade")
                }
            }
        }
        
        
    }
}
