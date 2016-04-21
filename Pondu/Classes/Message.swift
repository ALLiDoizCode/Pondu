//
//  Message.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Message:NSObject {
    
    var entityId:String?
    var threadId:String?
    var messageText:String?
    var sender:String?
    var media:String = ""
    var date:NSDate?
    var metadata:KCSMetadata?
    
    override init() {
        super.init()
    }
    
    init(theDescription:String){
        
        messageText = theDescription
    }
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId,
            "messageText" : "messageText",
            "media" : "media",
            "sender" : "sender",
            "threadId":"threadId",
            "metadata" : KCSEntityKeyMetadata
        ]
    }
    
    /*override class func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        
        return [
            "thread" : "MessageThread",
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        
        return [ "thread" ]
    }*/
    
}