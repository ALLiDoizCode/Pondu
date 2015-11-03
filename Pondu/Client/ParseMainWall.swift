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
                                    let live = object.objectForKey("Live") as! Bool!
                                    //self.mainWallID.append(object.objectId!)
                                
                                
                                
                                if let theVideo = video, let theThumbImage = thumbImage{
                                    
                                    if let favID = favId {
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:true,theLive:live)
                                                
                                                
                                                
                                                print("there are \(favID.count) fav ids")
                                                
                                                if object.objectId == favID[i] {
                                                    
                                                    print("queryID \(mainWalldata)")
                                                    print("recived fav post")
                                                    mainWall.append(mainWalldata)
                                                    print("successfully recived \(mainWall.count) fav post")
                                                    print("sending fav post")
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: video.url!, theLikes: likes, theLocation: theAddress, theMainThumb: thumbImage.url!, theComments: comments,theFav:false,theLive:live)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }else if let theVideo = video where thumbImage == nil {
                                    
                                    let theThumb = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-47ac8439-6b52-401b-bc20-18a2b6a2c76c-Placeholder.svg"
                                    
                                    if let favID = favId {
                                        
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:true,theLive:live)
                                                
                                                
                                                
                                                print("there are \(favID.count) fav ids")
                                                
                                                if object.objectId == favID[i] {
                                                    
                                                    print("queryID \(mainWalldata)")
                                                    print("recived fav post")
                                                    mainWall.append(mainWalldata)
                                                    print("successfully recived \(mainWall.count) fav post")
                                                    print("sending fav post")
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: video.url!, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:false,theLive:live)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                    
                                } else if let theThumbImage = thumbImage where video == nil {
                                    
                                    
                                    let theVideo = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-6a5d1d3d-4319-4fe8-a5fa-16556508f115-SampleVideo_1080x720_1mb.mp4"
                                    
                                    if let favID = favId {
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:true,theLive:live)
                                                
                                                
                                                
                                                print("there are \(favID.count) fav ids")
                                                
                                                if object.objectId == favID[i] {
                                                    
                                                    print("queryID \(mainWalldata)")
                                                    print("recived fav post")
                                                    mainWall.append(mainWalldata)
                                                    print("successfully recived \(mainWall.count) fav post")
                                                    print("sending fav post")
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumbImage.url!, theComments: comments,theFav:false,theLive:live)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }else{
                                    let theVideo = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-6a5d1d3d-4319-4fe8-a5fa-16556508f115-SampleVideo_1080x720_1mb.mp4"
                                    
                                    let theThumb = "http://files.parsetfss.com/bab4026e-aa7e-4962-8128-6876de5fccc3/tfss-47ac8439-6b52-401b-bc20-18a2b6a2c76c-Placeholder.svg"
                                    
                                    if let favID = favId {
                                        
                                        
                                        for var i = 0; i<objects.count; i++ {
                                            
                                            if i < favID.count {
                                                
                                                let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:true,theLive:live)
                                                
                                                
                                                
                                                print("there are \(favID.count) fav ids")
                                                
                                                if object.objectId == favID[i] {
                                                    
                                                    print("queryID \(mainWalldata)")
                                                    print("recived fav post")
                                                    mainWall.append(mainWalldata)
                                                    print("successfully recived \(mainWall.count) fav post")
                                                    print("sending fav post")
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                        let mainWalldata:Event = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!, theVideo: theVideo, theLikes: likes, theLocation: theAddress, theMainThumb: theThumb, theComments: comments,theFav:false,theLive:live)
                                        
                                        mainWall.append(mainWalldata)
                                        
                                    }
                                }

                                
                                
                            }
                            
                            print("items in mainwall \(mainWall.count)")
                            
                            if mainWall[0].fav == true {
                                print("fav count \(mainWall.count)")
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

}

