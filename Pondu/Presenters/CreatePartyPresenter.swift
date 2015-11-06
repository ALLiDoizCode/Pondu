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
    
    func party(theName: String, thePost: String, TheProfilePicture: UIImage,theLocation: String, theLive: Bool,thelikes:Int){
        
        startParty.theParty()
        
        let profilePictureData = UIImagePNGRepresentation(TheProfilePicture)
        
        let theParty:makeParty = makeParty(theName: theName, thePost: thePost, TheProfilePicture: profilePictureData!, theLocation: theLocation, theLive: theLive,thelikes:thelikes)
        
        SwiftEventBus.post("makeParty", sender: theParty)
    }
    
}
