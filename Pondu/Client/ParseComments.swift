//
//  ParseComments.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class comments {

    let wall = PFQuery(className: "MainWall")
    let commentList = PFObject(className: "Comments")
    let currentUser = PFUser.currentUser()
    
    func addComment(objectId:String,description:String,completion:(success:Bool) -> Void){
        
        commentList["Description"] = description
        commentList["CreatedBy"] = currentUser
        
        commentList.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                
                self.wall.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
                    
                    if error == nil {
                        
                        let comment = object?.objectForKey("Comments") as! PFObject
                        
                        let relation = comment.relationForKey("Comments")
                        
                        relation.addObject(self.commentList)
                        
                        comment.saveInBackgroundWithBlock({ (success, error) -> Void in
                            
                            if success {
                                
                                print("Sucessfully added comment")
                                
                                completion(success: success)
                            }
                        })
                        
                    }
                }
            }
        }
    }
}
