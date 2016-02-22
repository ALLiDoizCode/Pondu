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
    
    static let sharedInstance = ParseMainWall()
    
    var mainWallID:[String] = []
    
    let currentUser = PFUser.currentUser()
    
    func postQuery(){
        
        var wall:[Event] = []
        var comment:[Comment] = []
        var liveContent:[Content] = []
        
        let query = PFQuery(className: "Events")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            
            if let objects = objects {
                
                for object in objects {
                    
                    let relation = object.relationForKey("Events")
                    let eventQuery = relation.query()
                    
                    eventQuery!.findObjectsInBackgroundWithBlock {
                        (eventObjects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            print("Successfully retrieved \(eventObjects!.count) Posts.")
                            
                            // Do something with the found objects
                            if let eventObjects = eventObjects {
                                for object in eventObjects {
                                    print(object.objectId)
                                    let theID = object.objectId
                                    let post = object.objectForKey("Post") as! String!
                                    let profileName = object.objectForKey("Name") as! String!
                                    let createdBy = object.objectForKey("CreatedBy") as! PFObject
                                    let profileImage = createdBy.objectForKey("photo") as! PFFile
                                    let comments = object.objectForKey("Comments") as! PFObject
                                    let content = object.objectForKey("LiveContent") as! PFObject
                                    
                                    let contentData = content.relationForKey("Content")
                                    
                                    let contentQuery = contentData.query()
                                    
                                    let commentsData = comments.relationForKey("Comments")
                                    
                                    let commentQuery = commentsData.query()
                                    
                                    
                                    print("the Event is firing \(post)")
                                    
                                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!,theComments:comment,theContent:liveContent)
                                    
                                    wall.append(theEvent)
                                    
                                    print("number of media items \(liveContent.count) ")
                                    
                                    commentQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                        
                                        if let objects = objects {
                                            
                                            for object in objects {
                                                
                                                let createdBy = object.objectForKey("CreatedBy") as! PFUser
                                                let userImage = createdBy["photo"] as! PFFile
                                                let description = object.objectForKey("Description") as! String
                                                let date = object.createdAt
                                                
                                                let commentInfo:Comment = Comment(theDescription: description, theCreatorImage: userImage.url!, theCreatorName: createdBy.username!, theTime: date!)
                                                
                                                comment.append(commentInfo)
                                            }
                                            
                                        }
                                        
                                       
                                    })
                                    
                                    
                                    
                                }
                                
                               
                               SwiftEventBus.post("MainWallEvent", sender: wall)
                               
                                
                            } else {
                                
                                // Log details of the failure
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                        }
                    }
                    
                }
            }
            
            
        }
}
    
    func comments(objectId:String){
        
        var data:[Comment] = []
        let query = PFQuery(className: "MainWall")
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            
            if let object = object {
                
                let comment = object.objectForKey("Comments") as! PFObject
                
                let relation = comment.relationForKey("Comments")
                
                let commentQuery = relation.query()
                
                commentQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            let description = object.objectForKey("Description") as! String
                            let createdBy = object.objectForKey("CreatedBy") as! PFUser
                            let userImage = createdBy.objectForKey("photo") as! PFFile
                            let userName = createdBy.username
                            let time = object.createdAt
                            
                            let theComment = Comment(theDescription: description, theCreatorImage: userImage.url!, theCreatorName: userName!, theTime: time!)
                            
                            data.append(theComment)
                            print(description)
                        }
                        
                        
                        SwiftEventBus.post("EventComments", sender: data)
                    }
                })
            }
        }
    }
    
    func liveContent(objectId:String){
        
        
        var data:[String] = []
        let query = PFQuery(className: "MainWall")
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            
            if let object = object {
                
                let content = object.objectForKey("LiveContent") as! PFObject
                
                let relation = content.relationForKey("Content")
                
                let contentQuery = relation.query()
                
                contentQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    
                    if let objects = objects {
                        
                        for object in objects {
                            
                            let media = object.objectForKey("Media") as! PFFile
                            
                            data.append(media.url!)
                            print(media.url)
                        }
                        
                        
                        SwiftEventBus.post("EventContent", sender: data)
                    }
                })
            }
        }
    }
    
    func favEvents(){
        
        let relation = currentUser?.relationForKey("FavEvents")
        let query = relation?.query()
        
        var wall:[Event] = []
        var comment:[Comment] = []
        var liveContent:[Content] = []
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            print("boom \(objects?.count)")
            
            if let objects = objects {
                
                for object in objects {
                    
                    
                    let event = object.objectForKey("FavEvents") as! PFObject
                    let theID = event.objectId
                    let post = event.objectForKey("Post") as! String!
                    let profileName = event.objectForKey("Name") as! String!
                    let createdBy = event.objectForKey("CreatedBy") as! PFObject
                    let profileImage = createdBy.objectForKey("photo") as! PFFile
                    let comments = event.objectForKey("Comments") as! PFObject
                    let content = event.objectForKey("LiveContent") as! PFObject
                    
                    let contentData = content.relationForKey("Content")
                    
                    let contentQuery = contentData.query()
                    
                    let commentsData = comments.relationForKey("Comments")
                    
                    let commentQuery = commentsData.query()
                    
                    commentQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                        
                        if let objects = objects {
                            
                            for object in objects {
                                
                                let createdBy = object.objectForKey("CreatedBy") as! PFUser
                                let userImage = createdBy["photo"] as! PFFile
                                let description = object.objectForKey("Description") as! String
                                let date = object.createdAt
                                
                                let commentInfo:Comment = Comment(theDescription: description, theCreatorImage: userImage.url!, theCreatorName: createdBy.username!, theTime: date!)
                                
                                comment.append(commentInfo)
                            }
                            
                        }
                        
                        contentQuery?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            
                            if let objects = objects {
                                
                                for object in objects {
                                   
                                    if let media:PFFile = createdBy["Media"] as? PFFile {
                                        
                                        let title = object.objectForKey("Title") as! String
                                        
                                        let contentInfo:Content = Content(theMedia: media.url!, theTitle: title)
                                        
                                        liveContent.append(contentInfo)
                                    }
                                }
                                
                            }
                            
                        })
                
                    })
                    
                    print("the favEvent is firing \(post)")
                    
                    let theEvent = Event(theID: theID!, theName: profileName, thePost: post, TheProfilePicture: profileImage.url!,theComments:comment,theContent:liveContent)
                    
                    wall.append(theEvent)
                    
                }
                
                SwiftEventBus.post("FavEvent", sender: wall)
            }
            
            
        })

    }

}