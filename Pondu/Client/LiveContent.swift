//
//  LiveContent.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class LiveContent {
    
    let wall = PFQuery(className: "MainWall")
    let contentList = PFObject(className: "LiveContent")
    let currentUser = PFUser.currentUser()
    
    func content(objectId:String,title:String){
        
        let mediaData = UIImageJPEGRepresentation(UIImage(named: "girl")!, 1.8)
        let mediaFile = PFFile(name:"photo", data:mediaData!)
        
        contentList["Title"] = title
        contentList["Media"] = mediaFile
        contentList["CreatedBy"] = currentUser
        
        contentList.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                
                self.wall.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
                    
                    if error == nil {
                        
                        let comment = object?.objectForKey("LiveContent") as! PFObject
                        
                        let relation = comment.relationForKey("Content")
                        
                        relation.addObject(self.contentList)
                        
                        comment.saveInBackgroundWithBlock({ (success, error) -> Void in
                            
                            if success {
                                
                                print("Sucessfully added Content")
                            }
                        })
                        
                    }
                }
            }
        }
    }
}
