//
//  GetCommetns.swift
//  Pondu
//
//  Created by Jonathan Green on 2/21/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus


class Comments {
    
    let client = ParseMainWall.sharedInstance
    
    func getComments(objectId:String,completion:(data:[Comment]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "EventComments") { result in
            
            if let comments:[Comment] = result.object as? [Comment] {
                
                completion(data: comments)
            }
        }
        
        client.comments(objectId)
    }
}