//
//  CommentClient.swift
//  Pondu
//
//  Created by Jonathan Green on 4/21/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class CommentClient {
    
    let store = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Comment",
        KCSStoreKeyCollectionTemplateClass : Comment.self
        ])
    
    func saveComment(comment:Comment) {
        
        self.store.saveObject(comment, withCompletionBlock: { (objects, error) in
            
            if error != nil {
                //save failed
                NSLog("Save failed, with error: %@", error.localizedFailureReason!)
            } else {
                //save was successful
                NSLog("Successfully saved event (id='%@').", (objects[0] as! NSObject).kinveyObjectId())
                
            }
            
            }, withProgressBlock: nil)
    }
    
    func getComments(postId:String) {
        
        let query = KCSQuery(onField: "postId", withExactMatchForValue: postId)
        
        self.store.queryWithQuery(query, withCompletionBlock: { (objects, error) in
            
            
            
            }, withProgressBlock: nil)
    }
}