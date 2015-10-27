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
    
    func eventPost(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
        let post = result.object
            print(post)
            

        }
        
        mainWall.postQuery()

    }
    
    func eventID(arrayID:[String]){
        
        SwiftEventBus.onMainThread(self, name: "MainWallID") { result in
            
            let arrayID = result.object
            self.makecomment.makeComment((arrayID?[0])! as! String)
            print("comments\(arrayID)")
            
        }
        
        mainWall.idQuery()
        
    }
    
    
    func eventIcon(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "MainWallImage") { result in
            
            let eventImage = result.object
            print(eventImage)
            
            //imageView.kf_setImageWithURL(NSURL(string: eventImage)!)
            
        }
        
        mainWall.ImageQuery()
    }
    
    func eventThumb(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "MainWallThumbImage") { result in
            
            let thumbImage = result.object
            print(thumbImage)
            
           // imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            
        }
        
        mainWall.ThumbQuery()
    }
    
    func eventTime(){
        
        
    }
    
    func eventCL(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "MainWallLikes") { result in
            
           let eventlikes = result.object
            print(eventlikes)
            
        }
        
        mainWall.likesQuery()
        
    }
    
    func eventCM(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "MainWallComments") { result in
            
            let eventComments = result.object
            print(eventComments)
            
        }
        
        mainWall.commentsQuery()
        
    }
    
    func profileName(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "MainWallProfileName") { result in
            
            let eventprofileName = result.object
            print(eventprofileName)
            
        }
        
        mainWall.profileNameQuery()
        
    }
    
    func eventAddress(button:UIButton){
        
        SwiftEventBus.onMainThread(self, name: "MainWallAddress") { result in
            
           let address = result.object
            print(address)
            //button.setTitle(address, forState: UIControlState.Normal)
            
        }
        
        mainWall.eventAddressQuery()
        
    }
    
    //need to pass a refrence to a video player
    func eventVideo(){
        
        SwiftEventBus.onMainThread(self, name: "MainWallVideo") { result in
            
            let video = result.object
            print(video)
            //let URL = NSURL(string: video)!
            
            //print(URL)
            
        }
        
        mainWall.videoQuery()
        
    }
}

