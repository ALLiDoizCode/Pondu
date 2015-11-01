//
//  ParseParties.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class ParseParties {
    
    var partyMainWallID:[String] = []
    
    func postQuery(favId:[String]?){
        
        var eventPost:[String] = []
        var favPost:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Posts.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(name)
                        
                        if let post = object.objectForKey("Posts") as! String! {
                            
                            self.partyMainWallID.append(object.objectId!)
                            
                            if let favID = favId {
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(post)")
                                            print("recived fav post")
                                            favPost.append(post)
                                        }
                                    }
                                    
                                }
                            }else{
                                print(post)
                                eventPost.append(post)
                                
                            }
                        }
                        
                    }
                    
                    if favId != nil {
                        print("fav count \(favPost.count)")
                        var postArray:[AnyObject] = []
                        postArray.append(favPost)
                        SwiftEventBus.post("partyFavoritesList", sender: postArray )
                    }else {
                        
                        var mainWallData:[AnyObject] = []
                        mainWallData.append(eventPost)
                        mainWallData.append(self.partyMainWallID)
                        print(mainWallData.count)
                        SwiftEventBus.post("PartyEvent", sender: mainWallData)
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func ImageQuery(favId:[String]?){
        
        var eventProfileImage:[String] = []
        var favProfileImage:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) ProfileImages.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        
                        //let profileImage:PFFile!
                        
                        if let profileImage = object.objectForKey("ProfilePicture") as! PFFile! {
                            
                            if let favID = favId {
                                
                                print("favID not nil")
                                print(favID.count)
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(profileImage.url)")
                                            
                                            print("recived fav Image")
                                            
                                            if let favImage:PFFile! = profileImage {
                                                
                                                favProfileImage.append(favImage.url!)
                                                print("successfully recived \(favProfileImage.count) fav Image")
                                            }
                                            
                                           
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }else{
                                
                                eventProfileImage.append(profileImage.url!)
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                if favId != nil {
                    
                    print("sending fav image")
                    print(favProfileImage.count)
                    var postArray:[AnyObject] = []
                    postArray.append(favProfileImage)
                    SwiftEventBus.post("partyfavImage", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventProfileImage)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesImage", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func ThumbQuery(favId:[String]?){
        
        var eventThumbImage:[String] = []
        var favThumbImage:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) ProfileImages.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let ThumbImage = object.objectForKey("Mainthumb") as! PFFile! {
                            
                            if let favID = favId {
                                
                                print("favID not nil")
                                print(favID.count)
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(ThumbImage.url)")
                                            
                                            print("recived fav ThumbImage")
                                            
                                            if let favImage:PFFile! = ThumbImage {
                                                
                                                favThumbImage.append(favImage.url!)
                                                print("successfully recived \(favThumbImage.count) fav ThumbImage")
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }else{
                                
                                eventThumbImage.append(ThumbImage.url!)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                if favId != nil {
                    
                    print("sending fav image")
                    print(favThumbImage.count)
                    var postArray:[AnyObject] = []
                    postArray.append(favThumbImage)
                    SwiftEventBus.post("partyfavThumbImage", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventThumbImage)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesThumbImage", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
    }
    
    func likesQuery(favId:[String]?){
        
        var eventLikes:[String] = []
        var favLikes:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Likes.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let Likes = object.objectForKey("Likes") as! String! {
                            
                            if let favID = favId {
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(Likes)")
                                            print("recived fav Likes")
                                            favLikes.append(Likes)
                                            
                                            
                                        }
                                    }
                                    
                                }
                            }else{
                                
                                eventLikes.append(Likes)
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                if favId != nil{
                    
                    print("successfully recived \(favLikes.count) fav Likes")
                    print("sending fav Likes")
                    var postArray:[AnyObject] = []
                    postArray.append(favLikes)
                    SwiftEventBus.post("partyfavLikes", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventLikes)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesLikes", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func commentsQuery(favId:[String]?){
        
        var eventComments = []
        var favComments = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Comments.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let Comments = object.objectForKey("Comments") as! NSArray! {
                            
                            if let favID = favId {
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(Comments)")
                                            print("recived fav Comments")
                                            favComments = Comments
                                           
                                            
                                        }
                                    }
                                    
                                }
                            }else{
                                
                                eventComments = Comments
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                if favId != nil{
                    
                    print("successfully recived \(favComments.count) fav Comments")
                    print("sending fav Comments")
                    var postArray:[AnyObject] = []
                    postArray.append(favComments)
                    SwiftEventBus.post("partyfavComments", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventComments)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesComments", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func profileNameQuery(favId:[String]?){
        
        var eventprofileName:[String] = []
        var favProfileName:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) profileNames.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let profileName = object.objectForKey("Name") as! String! {
                            
                            if let favID = favId {
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(profileName)")
                                            print("recived fav profileName")
                                            favProfileName.append(profileName)
                                            
                                            
                                        }
                                    }
                                    
                                }
                            }else{
                                
                                eventprofileName.append(profileName)
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
                if favId != nil{
                    
                    print("successfully recived \(favProfileName.count) fav profileName")
                    print("sending fav profileName")
                    var postArray:[AnyObject] = []
                    postArray.append(favProfileName)
                    SwiftEventBus.post("partyfavProfileName", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventprofileName)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesProfileName", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func eventAddressQuery(favId:[String]?){
        
        var address:[String] = []
        var favAddress:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) address.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let theAddress = object.objectForKey("Location") as! String! {
                            
                            if let favID = favId {
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(theAddress)")
                                            print("recived fav address")
                                            favAddress.append(theAddress)
                                            
                                            
                                        }
                                    }
                                    
                                }
                            }else{
                                
                                address.append(theAddress)
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
                if favId != nil{
                    
                    print("successfully recived \(favAddress.count) fav address")
                    print("sending fav address")
                    var postArray:[AnyObject] = []
                    postArray.append(favAddress)
                    SwiftEventBus.post("partyfavAddress", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(address)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesAddress", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    func videoQuery(favId:[String]?){
        
        var eventVideo:[String] = []
        var favVideo:[String] = []
        
        let query = PFQuery(className:"Parties")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) videos.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let video = object.objectForKey("Video") as! PFFile! {
                            
                            if let favID = favId {
                                
                                print("favID not nil")
                                print(favID.count)
                                
                                for var i = 0; i<objects.count; i++ {
                                    
                                    if i < favID.count {
                                        
                                        if object.objectId == favID[i] {
                                            
                                            print("queryID \(video.url)")
                                            
                                            print("recived fav video")
                                            
                                            if let theVideo:PFFile! = video {
                                                
                                                favVideo.append(theVideo.url!)
                                                print("successfully recived \(favVideo.count) fav video")
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                            }else{
                                
                                eventVideo.append(video.url!)
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
                if favId != nil{
                    
                    print("sending fav video")
                    print(favVideo.count)
                    var postArray:[AnyObject] = []
                    postArray.append(favVideo)
                    SwiftEventBus.post("partyfavVideo", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventVideo)
                    mainWallData.append(self.partyMainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("PartiesVideo", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
}

