//
//  CreateEventPresenter.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher

class MakingEvent {
    
    let startEvent = createEvent()
    
    func event(theName: String, thePost: String,theAddress: String, theLive: Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String,thePrivacy:Bool,theLat:Double,theLong:Double){
        
        SwiftEventBus.post("makeEvent", sender: theEvent)
    }
    
}

