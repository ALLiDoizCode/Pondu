//
//  makeEvent.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Parse

class makeEvent {
    
    var name:String = ""
    var post:String = ""
    var profilePicture:PFFile!
    var likes:Int = 0
    var lat:Double!
    var long:Double!
    var address:String!
    var live:Bool = false
    var date:String!
    var startTime:String!
    var endTime:String!
    var privacy:Bool!
    
    init(theName:String,thePost:String,TheProfilePicture:PFFile,theAddress:String,theLive:Bool,thelikes:Int,theDate:String,theStartTime:String,theEndTime:String,thePrivacy:Bool,theLat:Double,theLong:Double){
        
        name = theName
        post = thePost
        profilePicture = TheProfilePicture
        address = theAddress
        lat = theLat
        long = theLong
        live = theLive
        likes = thelikes
        date = theDate
        startTime = theStartTime
        endTime = theEndTime
        privacy = thePrivacy
    }
    
}
