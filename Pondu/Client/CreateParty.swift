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
        
        
        let file = currentUser?.objectForKey("photo") as! PFFile
        
        SwiftEventBus.onMainThread(self, name: "makeParty") { result in
            
            let createdParty = result.object as! makeParty
            
            event["userID"] = currentUser?.objectId
            event["Posts"] = createdParty.post
            event["Name"] = currentUser?.username
            event["Live"] = createdParty.live
            event["Comments"] = [""]
            event["Likes"] = 0
            event["Location"] = createdParty.location
            event["ProfilePicture"] = currentUser!["photo"]
            event["Time"] = createdParty.startTime
            event["Privacy"] = createdParty.privacy
             event.addObject(file, forKey: "LiveContent")
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

