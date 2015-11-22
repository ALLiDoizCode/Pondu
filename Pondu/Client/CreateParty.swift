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
        
        let event = PFObject(className: "Parties")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "makeParty") { result in
            
            let createdEvent = result.object as! makeParty
            
            event["userID"] = currentUser?.objectId
            event["Posts"] = createdEvent.post
            event["Name"] = createdEvent.name
            event["Live"] = createdEvent.live
            event["Comments"] = [""]
            event["Likes"] = 0
            event["Location"] = createdEvent.location
            event["ProfilePicture"] = currentUser!["photo"]
            event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    print("Party made")
                    SwiftEventBus.post("PartyMade")
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the Party")
                    SwiftEventBus.post("PartyNotMade")
                }
            }
        }
        
        
    }
}

