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
import Kingfisher

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
    
    func eventID(arrayID:[String]){
        
        SwiftEventBus.onMainThread(self, name: "MainWallID") { result in
            
            if let arrayID = result.object {
                
                if arrayID.count > 0 {
                    
                    self.makecomment.makeComment((arrayID[0])! as! String)
                }
                
                 print("comments\(arrayID)")
                
            }
            
           
            
            SwiftEventBus.unregister(self, name: "MainWallID")
            
        }
        
        mainWall.idQuery()
        
    }
    
}

