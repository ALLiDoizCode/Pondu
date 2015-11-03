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
    
    var mainWallID:[String] = []
    
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
        
                var eventPost:[AnyObject] = Array()
                var favPost:[String] = []
                var mainWall:[Event] = []
        
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
                                
                                    let theID = object.objectId
                                    let post = object.objectForKey("Post") as! String!
                                    let profileImage = object.objectForKey("ProfilePicture") as! PFFile!
                                    let thumbImage = object.objectForKey("Mainthumb") as! PFFile!
                                    let likes = object.objectForKey("Likes") as! String!
                                    let comments = object.objectForKey("Comments") as! [String]!
                                    let profileName = object.objectForKey("Name") as! String!
                                    let theAddress = object.objectForKey("Location") as! String!
                                    let video = object.objectForKey("Video") as! PFFile!
                                    //self.mainWallID.append(object.objectId!)
                                
                                
                                
                                if let theVideo = video, let theThumbImage = thumbImage{
                                    
                                    if let favID = favId {
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:true)
                                                
                                                mainWall.append(mainWalldata)
                                                
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
                                        
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: video.url!, theLikes: likes, theLocation: theAddress, theMainThumb: thumbImage.url!, theComments: comments,theFav:false)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }else if let theVideo = video where thumbImage == nil {
                                    
                                    let theThumb = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-47ac8439-6b52-401b-bc20-18a2b6a2c76c-Placeholder.svg"
                                    
                                    if let favID = favId {
                                        
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:true)
                                                
                                                mainWall.append(mainWalldata)
                                                
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
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: video.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:false)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                    
                                } else if let theThumbImage = thumbImage where video == nil {
                                    
                                    
                                    let theVideo = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-6a5d1d3d-4319-4fe8-a5fa-16556508f115-SampleVideo_1080x720_1mb.mp4"
                                    
                                    if let favID = favId {
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:true)
                                                
                                                mainWall.append(mainWalldata)
                                                
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
                                        
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:false)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }else{
                                    let theVideo = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-6a5d1d3d-4319-4fe8-a5fa-16556508f115-SampleVideo_1080x720_1mb.mp4"
                                    
                                    let theThumb = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-47ac8439-6b52-401b-bc20-18a2b6a2c76c-Placeholder.svg"
                                    
                                    if let favID = favId {
                                        
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:true)
                                                
                                                mainWall.append(mainWalldata)
                                                
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
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:false)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }

                                
                                
                            }
                            
                            print("items in mainwall \(mainWall.count)")
                            
                            if mainWall[0].fav == true {
                                print("fav count \(favPost.count)")
                                /*var postArray:[AnyObject] = []
                                postArray.append(favPost)*/
                                SwiftEventBus.post("FavoritesList", sender: mainWall)
                            }else {
                                
                                //var mainWallData:[AnyObject] = []
                                //mainWallData.append(eventPost)
                                //mainWallData.append(self.mainWallID)
                                print("mainwall count \(mainWall.count)")
                                SwiftEventBus.post("MainWallEvent", sender: mainWall)
                            }
                            
                        }
                    } else {

                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }
    
            /*func ImageQuery(favId:[String]?){
                
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
                                var postArray:[AnyObject] = []
                                postArray.append(favProfileImage)
                                SwiftEventBus.post("favImage", sender: postArray)
                                
                            }else{
                                var mainWallData:[AnyObject] = []
                                mainWallData.append(eventProfileImage)
                                mainWallData.append(self.mainWallID)
                                print(mainWallData.count)
                                SwiftEventBus.post("MainWallImage", sender: mainWallData)
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
                        var postArray:[AnyObject] = []
                        postArray.append(favThumbImage)
                        SwiftEventBus.post("favThumbImage", sender: postArray)
                        
                    }else{
                        var mainWallData:[AnyObject] = []
                        mainWallData.append(eventThumbImage)
                        mainWallData.append(self.mainWallID)
                        print(mainWallData.count)
                        SwiftEventBus.post("MainWallThumbImage", sender: mainWallData)
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
                        var postArray:[AnyObject] = []
                        postArray.append(favLikes)
                        SwiftEventBus.post("favLikes", sender: postArray)
                        
                    }else{
                        var mainWallData:[AnyObject] = []
                        mainWallData.append(eventLikes)
                        mainWallData.append(self.mainWallID)
                        print(mainWallData.count)
                        SwiftEventBus.post("MainWallLikes", sender: mainWallData)
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
                    var postArray:[AnyObject] = []
                    postArray.append(favComments)
                    SwiftEventBus.post("favComments", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventComments)
                    mainWallData.append(self.mainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("MainWallComments", sender: mainWallData)
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
                    var postArray:[AnyObject] = []
                    postArray.append(favProfileName)
                    SwiftEventBus.post("favProfileName", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventprofileName)
                    mainWallData.append(self.mainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("MainWallProfileName", sender: mainWallData)
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
                    var postArray:[AnyObject] = []
                    postArray.append(favAddress)
                    SwiftEventBus.post("favAddress", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(address)
                    mainWallData.append(self.mainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("MainWallAddress", sender: mainWallData)
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
                    var postArray:[AnyObject] = []
                    postArray.append(favVideo)
                    SwiftEventBus.post("favVideo", sender: postArray)
                    
                }else{
                    var mainWallData:[AnyObject] = []
                    mainWallData.append(eventVideo)
                    mainWallData.append(self.mainWallID)
                    print(mainWallData.count)
                    SwiftEventBus.post("MainWallVideo", sender: mainWallData)
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }*/

}

