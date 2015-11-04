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

class MakeEvent {
    
    let startEvent = createEvent()
    
    func event(theName: String, thePost: String, TheProfilePicture: UIImage,theLocation: String, theLive: Bool){
        
        startEvent.theEvent()
        
        let profilePictureData = UIImagePNGRepresentation(TheProfilePicture)
        
        let theEvent:makeEvent = makeEvent(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData!, theLocation: theLocation, theLive: theLive)
        
        SwiftEventBus.post("makeEvent", sender: theEvent)
    }
    
}

