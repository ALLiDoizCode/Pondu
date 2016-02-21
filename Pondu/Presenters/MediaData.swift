//
//  MediaData.swift
//  Pondu
//
//  Created by Jonathan Green on 2/21/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class WallContent {
    
    let client = ParseMainWall.sharedInstance
    
    func getContent(objectId:String,completion:(Data:[String]) -> Void) {
        
        SwiftEventBus.onMainThread(self, name: "EventContent") { result in
            
            if let mediaData:[String] = result.object as? [String] {
                
                completion(Data: mediaData)
            }
        }
        
        client.liveContent(objectId)
    }
}