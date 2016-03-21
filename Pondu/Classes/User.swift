//
//  User.swift
//  Pondu
//
//  Created by Jonathan Green on 11/1/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class userData {
    
    var objectID:String = ""
    var area:String = ""
    var fullName:String = ""
    var userName:String = ""
    var passWord:String = ""
    var bio:String = ""
    var phone:String = ""
    var email:String = ""
    var story:String = ""
    var photo:String = ""
    var fav:Bool!
    var year:String!
    
    init(theObjectID:String,theArea:String,theFullName:String,theUserName:String,thePassWord:String,theBio:String,thePhone:String,theEmail:String,theStory:String,thePhoto:String,theFav:Bool,theYear:String){
        
        
        objectID = theObjectID
        area = theArea
        fullName = theFullName
        userName = theUserName
        passWord = thePassWord
        bio = theBio
        phone = thePhone
        email = theEmail
        story = theStory
        photo = thePhoto
        fav = theFav
        year = theYear
        
    }
    
}
