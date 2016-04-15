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
    //var liveContent:Content = Content(theMedia: "", theTitle: "")
    var date:NSDate?
    var startTime:NSDate?
    var endTime:NSDate?
    var privacy:NSNumber?
    var event:NSNumber?
    var geocoord: CLLocation?
    var createdBy:String?
    var creatorImage:String?
    
    init(theTitle:String,theDescription:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,isEvent:Bool,theGeo:CLLocation,theCreatedBy:String,theCreatorImage:String){
        
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
        createdBy = theCreatedBy
        creatorImage = theCreatorImage
    }
    
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "title" : "title",
            "address" : "address",
            "live" : "live",
            //"liveContent":"liveContent",
            "likes" : "likes",
            "date" : "date",
            "startTime" : "startTime",
            "endTime" : "endTime",
            "privacy" : "privacy",
            "geocoord" : KCSEntityKeyGeolocation,
            "createdBy": "createdBy",
            "creatorImage":"creatorImage",
            "event":"event"
            //"metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
    
    
    
    /*override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        
        return [
            
            "createdBy": KCSUserCollectionName,
            //"liveContent":"LiveContent"
        ]
    }
    
    internal override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        
        return [ "createdBy" ]
    }*/
    
    
}