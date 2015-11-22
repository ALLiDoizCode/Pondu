//
//  CreatePartyPresenter.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class MakingParty {
    
    let startParty = createParty()
    
    func party(theName: String, thePost: String,theLocation: String, theLive: Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String){
        
        startParty.theParty()
        
        let currentUser = PFUser.currentUser()
        
        let profilePictureData = currentUser?.objectForKey("photo") as! PFFile
        
        let theParty:makeParty = makeParty(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData, theLocation: theLocation, theLive: theLive,thelikes:thelikes,theDate:theDate,theStartTime: theStartTime,theEndTime: theEndTime)
        
        SwiftEventBus.post("makeParty", sender: theParty)
    }
    
}
