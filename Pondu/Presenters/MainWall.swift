//
//  MainWall.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class PresentMainWall {
    
    let mainWall = ParseMainWall()
    let makecomment = userComments()
    
    
    
    func eventPost(completion:(result:[Event]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
            if let post = result.object as? [Event] {
                
                print("event post \(post)")
                //SwiftEventBus.post("updateCell", sender: post)
                SwiftEventBus.unregister(self, name: "MainWallEvent")
                
                completion(result: post)
            }
           
        }
        
        mainWall.postQuery()

    }
    
    func favPost(completion:(result:[Event]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "FavEvent") { result in
            
            if let data:[Event] = result.object as? [Event] {
                
                SwiftEventBus.unregister(self, name: "FavEvent")
                completion(result: data)
            }
            
        }
        
        mainWall.favEvents()
    }
}

