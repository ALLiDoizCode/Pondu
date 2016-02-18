//
//  CreateStory.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import SwiftEventBus

class CreateStory {
    
    func theStory(){
        
        let story = PFObject(className: "Story")
        let comments = PFObject(className: "CommentTable")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "MakeStory") { result in
            
            //let createdParty = result.object as! makeParty
            
            let mediaData = UIImageJPEGRepresentation(UIImage(named: "girl")!, 1.8)
            let mediaFile = PFFile(name:"photo", data:mediaData!)
            
            story["Media"] = mediaFile
           
            
            story.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    let relation = currentUser!.relationForKey("Story")
                    relation.addObject(story)
                    
                    currentUser!.saveInBackgroundWithBlock({ (sucess:Bool, error:NSError?) -> Void in
                        
                        if success {
                            
                            print("story ID is \(story.objectId)")
                            
                            comments["CreatedStory"] = story
                            
                            comments.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                
                                if success {
                                    
                                    print("comments ID is \(comments.objectId)")
                                    
                                    story["Comments"] = comments
                                    
                                    story.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                        
                                        if success {
                                            
                                            print("event made")
                                            
                                            SwiftEventBus.post("EventMade")
                                        }
                                    })
                                }
                                
                            })
                        }
                        
                    })
                    
                    print("event made")
                    
                    SwiftEventBus.post("EventMade")
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the event")
                    SwiftEventBus.post("EventNotMade")
                }
            }
        }
        
        
    }
}