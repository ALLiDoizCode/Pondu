//
//  MainWall.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus

class PresentMainWall {
    
    let client = WallClient()

    func eventPost(completion:(result:[Wall]) -> Void){
        
        print("setting up eventbus")
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
            print("MainWall Fired")
            
            let post = result.object as! [Wall]
                
                print("event post \(post.count)")
                //SwiftEventBus.post("updateCell", sender: post)
                SwiftEventBus.unregister(self, name: "MainWallEvent")
                
                completion(result: post)
            
           
        }
        
        print("firing client")
         self.client.getPost()

    }
    
    func favPost(completion:(result:[Wall]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "FavEvent") { result in
            
            if let data:[Wall] = result.object as? [Wall] {
                
                SwiftEventBus.unregister(self, name: "FavEvent")
                completion(result: data)
            }
            
        }
        
    }
}

