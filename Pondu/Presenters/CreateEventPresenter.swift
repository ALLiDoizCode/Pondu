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
    
    func event(theName: String, thePost: String,theAddress: String, theLive: Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String,thePrivacy:Bool,theLat:Double,theLong:Double){
        
        startEvent.theEvent()
        
        let currentUser = PFUser.currentUser()
        
        let profilePictureData = currentUser?.objectForKey("photo") as! PFFile
        
        let theEvent:makeEvent = makeEvent(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData, theAddress: theAddress, theLive: theLive,thelikes:thelikes,theDate:theDate,theStartTime: theStartTime,theEndTime: theEndTime,thePrivacy:thePrivacy,theLat:theLat,theLong:theLong)
        
        SwiftEventBus.post("makeEvent", sender: theEvent)
    }
    
}

