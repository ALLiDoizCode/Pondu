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
    
    /*func getEventPost(){
        
        let mainWall = ParseMainWall()
        
        mainWall.postQuery()
    }*/
    
    
    func eventPost(label: UILabel){
        
        
        var post:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
        post = result.object![1] as! String
            print(post)
            
            label.text = post

        }
        
        let mainWall = ParseMainWall()
        
        mainWall.postQuery()

    }
    
    
    func eventIcon(){
        
        
    }
    
    func eventTime(){
        
        
    }
    
    func eventCL(){
        
        
    }
    
    func eventCM(){
        
        
    }
}

