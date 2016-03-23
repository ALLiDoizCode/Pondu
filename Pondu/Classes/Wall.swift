//
//  Wall.swift
//  Pondu
//
//  Created by Jonathan Green on 3/22/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Wall:NSObject {
    
    var entityId:String?
    var title:String?
    var post:String?
    var profilePicture:String?
    var likes:Int?
    var lat:Double?
    var long:Double?
    var address:String?
    var live:Bool?
    var date:NSDate?
    var startTime:NSDate?
    var endTime:NSDate?
    var privacy:Bool?
    
    init(theTitle:String,theDescription:String,TheProfilePicture:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,theLat:Double,theLong:Double){
        
        title = theTitle
        post = theDescription
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
    
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "title" : "title",
            "profilePicture" : "profilePicture",
            "address" : "address",
            "lat" : "lat",
            "long" : "long",
            "live" : "live",
            "likes" : "likes",
            "date" : "date",
            "startTime" : "startTime",
            "endTime" : "endTime",
            "privacy" : "privacy",
            "metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
}