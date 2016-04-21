//
//  Comment.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Comment:NSObject {
    
    var entityId:String?
    var text:String?
    var creatorImage:String?
    var creatorName:String?
    var time:NSDate = NSDate()
    var postId:String?
    
    init(theDescription:String,theCreatorName:String,thePostId:String){
        
        text = theDescription
        creatorName = theCreatorName
        postId = thePostId
    }
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId,
            "text" : "text",
            "creatorImage" : "creatorImage",
            "creatorName" : "creatorName",
            "postId":"postId",
        ]
    }
}