//
//  Message.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Message {
    
    var objectId:String!
    var description:String!
    var media:String?
    var sender:String!
    var icon:String!
    var date:NSDate!
    
    init(theObjectId:String,theDescription:String,theMedia:String,theSender:String,theIcon:String,theDate:NSDate){
        
        objectId = theObjectId
        description = theDescription
        media = theMedia
        sender = theSender
        icon = theIcon
        date = theDate
    }
}