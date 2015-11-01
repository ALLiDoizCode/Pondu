//
//  Events.swift
//  Pondu
//
//  Created by Jonathan Green on 11/1/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class Event {
    
    var objectID:String = ""
    //var eventType:String = ""
    //var school:[String] = []
    var name:String = ""
    var post:String = ""
    var profilePicture:String = ""
    var video:String = ""
    //var type:String = ""
    var likes:String = ""
    var location:String = ""
    var story:String = ""
    var mainthumb:String = ""
    var comments:[String] = []
    
    init(theID:String,theName:String,thePost:String,TheProfilePicture:String,theVideo:String,theLikes:String,theLocation:String,theStory:String,theMainThumb:String,theComments:[String]){

        objectID = theID
        name = theName
        post = thePost
        profilePicture = TheProfilePicture
        video = theVideo
        likes = theLikes
        location = theLocation
        story = theStory
        mainthumb = theMainThumb
        comments = theComments
    }
    
}
