//
//  Comment.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class Comment {
    
    var description:String!
    var creatorImage:String!
    var creatorName:String!
    var time:NSDate!
    
    init(theDescription:String,theCreatorImage:String,theCreatorName:String,theTime:NSDate){
        
        description = theDescription
        creatorImage = theCreatorImage
        creatorName = theCreatorName
        time = theTime
    }
}