//
//  MakeParty.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class makeParty {
    
    var name:String = ""
    var post:String = ""
    var profilePicture:NSData!
    var likes:Int = 0
    var location:String = ""
    var live:Bool = false
    
    init(theName:String,thePost:String,TheProfilePicture:NSData,theLocation:String,theLive:Bool,thelikes:Int){
        
        name = theName
        post = thePost
        profilePicture = TheProfilePicture
        location = theLocation
        live = theLive
        likes = thelikes
    }
    
}

