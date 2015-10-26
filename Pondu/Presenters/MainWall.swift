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
    
    func eventPost(label: UILabel){
        
        
        var post:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
        post = result.object![1] as! String
            print(post)
            
            label.text = post

        }
        
        mainWall.postQuery()

    }
    
    
    func eventIcon(imageView:UIImageView){
        
        var eventImage:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallImage") { result in
            
            eventImage = result.object![3] as! String
            print(eventImage)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
           imageView.kf_setImageWithURL(NSURL(string: eventImage)!)
            
        }
        
        mainWall.ImageQuery()
    }
    
    func eventTime(){
        
        
    }
    
    func eventCL(){
        
        
    }
    
    func eventCM(){
        
        
    }
}

