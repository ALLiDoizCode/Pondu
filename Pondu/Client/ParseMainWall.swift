//
//  ParseMainWall.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class ParseMainWall {
    
    func idQuery(){
        
        var eventID:[String] = []
        
        let query = PFQuery(className:"MainWall")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Ids.")
                
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(name)
                        
                        eventID.append(object.objectId!)
                    }
                    
                    SwiftEventBus.post("MainWallID", sender: eventID)
                    
                    SwiftEventBus.post("Favorite", sender: eventID)
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    
    func postQuery(favId:[String]?){
        
                var eventPost:[String] = []
                var favPost:[String] = []
        
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) Posts.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                //print(name)
                                
                                    if let post = object.objectForKey("Post") as! String! {
                                        
                                        if let favID = favId {
                                            
                                            for var i = 0; i<objects.count; i++ {
                                                
                                                if i < favID.count {
                                                
                                                    print("there are \(favID.count) fav ids")
                                                    
                                                if object.objectId == favID[i] {
                                        
                                                    print("queryID \(post)")
                                                    print("recived fav post")
                                                    favPost.append(post)
                                                    print("successfully recived \(favPost.count) fav post")
                                                    print("sending fav post")
                                                    
                                            
                                                
                                                    }
                                                    
                                                }
                                            
                                            }
                                            
                                        }else{
                                            
                                            eventPost.append(post)
                                            
                                           
                                    }
   
                                }
                                
                            }
                            
                            if favId != nil {
                                print("fav count \(favPost.count)")
                                SwiftEventBus.post("FavoritesList", sender: favPost )
                            }else {
                                SwiftEventBus.post("MainWallEvent", sender: eventPost)
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
                
                let query = PFQuery(className:"MainWall")
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
                                                    
                                                    print("sending fav image")
                                                    print(favProfileImage.count)
                                                    SwiftEventBus.post("favImage", sender: favProfileImage)
                                                }
                                                
                                                
                                            }
                                
                                        }
                                        
                                    }else{
                                        
                                        eventProfileImage.append(profileImage.url!)
                                        
                                        SwiftEventBus.post("MainWallImage", sender: eventProfileImage)
                                    }
                                    
                                 

                                }
                                
                               
                            }
                            
                            if favId != nil {
                                
                                print("sending fav image")
                                print(favProfileImage.count)
                                SwiftEventBus.post("favImage", sender: favProfileImage)
                                
                            }else{
                                
                                SwiftEventBus.post("MainWallImage", sender: eventProfileImage)
                            }
                            
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
        
        let query = PFQuery(className:"MainWall")
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
                    
                    if favId != nil {
                        
                        print("sending fav image")
                        print(favThumbImage.count)
                        SwiftEventBus.post("favThumbImage", sender: favThumbImage)
                        
                    }else{
                        SwiftEventBus.post("MainWallThumbImage", sender: eventThumbImage)
                    }
                    
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
        
        let query = PFQuery(className:"MainWall")
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
                    
                    if favId != nil{
                        
                        print("successfully recived \(favLikes.count) fav Likes")
                        print("sending fav Likes")
                        SwiftEventBus.post("favLikes", sender: favLikes)
                        
                    }else{
                        
                        SwiftEventBus.post("MainWallLikes", sender: eventLikes)
                    }
                    
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
        
        let query = PFQuery(className:"MainWall")
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
                    SwiftEventBus.post("favComments", sender: favComments)
                    
                }else{
                    
                    SwiftEventBus.post("MainWallComments", sender: eventComments)
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
        
        let query = PFQuery(className:"MainWall")
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
                    SwiftEventBus.post("favProfileName", sender: favProfileName)
                    
                }else{
                    
                    SwiftEventBus.post("MainWallProfileName", sender: eventprofileName)
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
        
        let query = PFQuery(className:"MainWall")
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
                    SwiftEventBus.post("favAddress", sender: favAddress)
                    
                }else{
                    
                    SwiftEventBus.post("MainWallAddress", sender: address)
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
        
        let query = PFQuery(className:"MainWall")
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
                    SwiftEventBus.post("favVideo", sender: favVideo)
                    
                }else{
                    
                    SwiftEventBus.post("MainWallVideo", sender: eventVideo)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }

}

