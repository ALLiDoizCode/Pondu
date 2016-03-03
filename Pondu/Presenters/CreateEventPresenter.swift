//
//  CreateEventPresenter.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class MakingEvent {
    
    let startEvent = createEvent()
    
    func event(theName: String, thePost: String,theLocation: String, theLive: Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String,thePrivacy:Bool){
        
        startEvent.theEvent()
        
        let currentUser = PFUser.currentUser()
        
        let profilePictureData = currentUser?.objectForKey("photo") as! PFFile
        
        let theEvent:makeEvent = makeEvent(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData, theLocation: theLocation, theLive: theLive,thelikes:thelikes,theDate:theDate,theStartTime: theStartTime,theEndTime: theEndTime,thePrivacy:thePrivacy)
        
        SwiftEventBus.post("makeEvent", sender: theEvent)
    }
    
}

