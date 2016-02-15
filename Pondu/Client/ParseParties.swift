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
        
        var parties:[Event] = []
        var liveURls:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Posts.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(name)
                        
                        let theID = object.objectId
                        let post = object.objectForKey("Posts") as! String!
                        let profileImage = object.objectForKey("ProfilePicture") as! PFFile!
                        let thumbImage = object.objectForKey("Mainthumb") as! PFFile!
                        let likes = object.objectForKey("Likes") as! Int!
                        let comments = object.objectForKey("Comments") as! [String]!
                        let profileName = object.objectForKey("Name") as! String!
                        let theAddress = object.objectForKey("Location") as! String!
                        let video = object.objectForKey("Video") as! PFFile!
                        let live = object.objectForKey("Live") as! Bool!
                        //let favorite = object.objectForKey("userID") as! String
                        //let time = object.objectForKey("Time") as! String
                        let privacy = object.objectForKey("Privacy") as! Bool!
                        let liveContent = object.objectForKey("LiveContent") as! [PFFile]!
                    
                }
                    
                    SwiftEventBus.post("partyFavoritesList", sender: parties )
                    SwiftEventBus.post("PartyEvent", sender: parties)
                    
                    
                    print("items in Parties \(parties.count)")
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}

}