//
//  makeEvent.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class makeEvent {
    
    var name:String = ""
    var post:String = ""
    var profilePicture:NSData!
    var likes:String = ""
    var location:String = ""
    var live:Bool = false
    
    init(theName:String,thePost:String,TheProfilePicture:NSData,theLocation:String,theLive:Bool){
        
        name = theName
        post = thePost
        profilePicture = TheProfilePicture
        location = theLocation
        live = theLive
    }
    
}
