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
    
    func getEventDescription(){
        
        let mainWall = ParseMainWall()
        
        mainWall.testQuery()
    }
    
    func eventDescription(){
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
            let name = result.object
            
            print(name)
            
        }
        
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

