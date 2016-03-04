//
//  MessageList.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class MessageList {
    
    var objectId:String!
    var icon:String!
    var name:String!
    var time:NSDate!
    var status:Bool!
    var createdBy:String!
    var recipient:String!
    var messages:[Message]!
    
    init(theIcon:String!,theName:String,theTime:NSDate,theStatus:Bool,theMessages:[Message],theCreadtedBy:String,theRecipient:String,theObjectId:String){
        
        icon = theIcon
        name = theName
        time = theTime
        status = theStatus
        messages = theMessages
        createdBy = theCreadtedBy
        recipient = theRecipient
        objectId = theObjectId
    }
}