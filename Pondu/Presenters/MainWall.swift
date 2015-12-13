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
    
    let nilArray:[String]! = nil
    
    func eventPost(){
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
            if let post = result.object {
                
                print("event post \(post)")
                SwiftEventBus.postToMainThread("updateCell", sender: post)
                SwiftEventBus.unregister(self, name: "MainWallEvent")
            }
           
        }
        
        mainWall.postQuery(nilArray)

    }
}

