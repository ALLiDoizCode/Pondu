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
            
            let relation = party.relationForKey("Parties")
            relation.addObject(wall)
            
            wall.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    let relation = party.relationForKey("Events")
                    relation.addObject(wall)
                    party.saveInBackground()
                    
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

