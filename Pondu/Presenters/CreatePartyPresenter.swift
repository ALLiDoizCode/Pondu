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
    
    func party(theName: String, thePost: String,theAddress: String, theLive: Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String,thePrivacy:Bool,theLat:Double,theLong:Double){
        
        startParty.theParty()
        
        let currentUser = PFUser.currentUser()
        
        let profilePictureData = currentUser?.objectForKey("photo") as! PFFile
        
        let theParty:makeParty = makeParty(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData, theAddress:theAddress, theLive: theLive,thelikes:thelikes,theDate:theDate,theStartTime: theStartTime,theEndTime: theEndTime,thePrivacy:thePrivacy,theLat: theLat,theLong: theLong)
        
        SwiftEventBus.post("makeParty", sender: theParty)
    }
    
}
