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
        
        let imageData = UIImagePNGRepresentation(UIImage(named: "bg")!)
        let imageFile = PFFile(name:"image.png", data:imageData!)
        let imageData2 = UIImagePNGRepresentation(UIImage(named: "girl")!)
        let imageFile2 = PFFile(name:"image.png", data:imageData2!)
        let imageData3 = UIImagePNGRepresentation(UIImage(named: "girl")!)
        let imageFile3 = PFFile(name:"image.png", data:imageData3!)
        
        let fileArray:[PFFile] = [imageFile!,imageFile2!,imageFile3!]
        
        SwiftEventBus.onMainThread(self, name: "makeEvent") { result in
            
            let createdEvent = result.object as! makeEvent
            
            event["userID"] = currentUser?.objectId
            event["Post"] = createdEvent.post
            event["Name"] = currentUser?.username
            event["Live"] = createdEvent.live
            event["Comments"] = [""]
            event["Likes"] = 0
            event["Location"] = createdEvent.location
            event["ProfilePicture"] = currentUser!["photo"]
            event["Time"] = createdEvent.startTime
            event["Privacy"] = createdEvent.privacy
            event["LiveContent"] = fileArray
            //event.addObject(fileArray, forKey: "LiveContent")
            event.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
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
