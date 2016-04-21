//
//  PresentComments.swift
//  Pondu
//
//  Created by Jonathan Green on 4/21/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class PresentComments {
    
    let client = CommentClient()
    
    func comment(comment:Comment){
        
        client.saveComment(comment)
    }
    
    func getComments(postId:String,completion:(data:[Comment]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "Comment") { result in
            
            if let comments:[Comment] = result.object as? [Comment] {
                
                completion(data: comments)
            }
            
            SwiftEventBus.unregister("Comment")
        }
        
        client.getComments(postId)
    }
}