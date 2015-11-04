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
        
        let event = PFObject(className: "MainWall")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "makeEvent") { result in
            
            let createdEvent = result.object as! makeEvent
            
            event["userID"] = currentUser?.objectId
            event["Post"] = createdEvent.post
            event["Name"] = createdEvent.name
            event["Live"] = createdEvent.live
            event["Comments"] = [""]
            event["Location"] = createdEvent.location
            event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    print("event made")
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the event")
                }
            }
        }
        
        
    }
}
