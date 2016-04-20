//
//  Thread.swift
//  Pondu
//
//  Created by Jonathan Green on 4/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Thread: NSObject {
    
    var entityId:String = NSUUID().UUIDString
    var user1:String?
    var user2:String?
    
    init(firstUser:String,secondUser:String) {
        
        user1 = firstUser
        user2 = secondUser
    }
    
    // This maps the properties in the class to specific values in the Kinvey
    // data store.
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : "entityId",
            "user1" : "user1",
            "user2" : "user2",
        ]
    }
    
}