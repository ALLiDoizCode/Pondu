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
    var name:String = ""
    var userName = ""
    var post:String = ""
    var profilePicture:String = ""
    var likes:Int = 0
    var live:Bool = false
    var comments:[Comment]!
    var content:[Content]!
    
    
    init(theID:String,theName:String,theUserName:String,thePost:String,TheProfilePicture:String,theComments:[Comment],theContent:[Content]){

        objectID = theID
        name = theName
        post = thePost
        profilePicture = TheProfilePicture
        comments = theComments
        content = theContent
        userName = theUserName
       
    }
}
