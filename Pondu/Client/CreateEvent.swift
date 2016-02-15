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
        let event = PFObject(withoutDataWithClassName: "Events", objectId: "gUHWW0VeZD")
        let currentUser = PFUser.currentUser()
        
        //let file = currentUser?.objectForKey("photo") as! PFFile
        
        SwiftEventBus.onMainThread(self, name: "makeEvent") { result in
            
            let createdEvent = result.object as! makeEvent
            
            wall["CreatedBy"] = currentUser
            wall["Post"] = createdEvent.post
            wall["Name"] = currentUser?.username
            wall["Live"] = createdEvent.live
            wall["Likes"] = 0
            wall["Privacy"] = createdEvent.privacy
            
            let relation = event.relationForKey("Events")
            relation.addObject(wall)
            
            wall.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    let relation = event.relationForKey("Events")
                    relation.addObject(wall)
                    event.saveInBackground()
                    
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
