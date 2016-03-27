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
    var likes:NSNumber?
    var address:String?
    var live:NSNumber?
    var liveContent:Content?
    var date:NSDate?
    var startTime:NSDate?
    var endTime:NSDate?
    var privacy:NSNumber?
    var event:Bool?
    var geocoord: CLLocation?
    var createdBy:KCSUser?
    
    init(theTitle:String,theDescription:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,isEvent:Bool,theGeo:CLLocation){
        
        title = theTitle
        post = theDescription
        address = theAddress
        live = theLive
        likes = thelikes
        date = theDate
        startTime = theStartTime
        endTime = theEndTime
        privacy = thePrivacy
        event = isEvent
        geocoord = theGeo
    }
    
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "title" : "title",
            "address" : "address",
            "live" : "live",
            "liveContent":"liveContent",
            "likes" : "likes",
            "date" : "date",
            "startTime" : "startTime",
            "endTime" : "endTime",
            "privacy" : "privacy",
            "geocoord" : KCSEntityKeyGeolocation,
            "createdBy": "createdBy"
            //"metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
    
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        
        return [
            
            "createdBy": KCSUserCollectionName,
            "liveContent":"LiveContent"
        ]
    }
    
    internal override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        
        return [ "createdBy" ]
    }
    
    
}