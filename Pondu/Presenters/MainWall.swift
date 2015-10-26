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
    
    func eventThumb(imageView:UIImageView){
        
        var thumbImage:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallThumbImage") { result in
            
            thumbImage = result.object![0] as! String
            print(thumbImage)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            
        }
        
        mainWall.ThumbQuery()
    }
    
    func eventTime(){
        
        
    }
    
    func eventCL(label:UILabel){
        
        var eventlikes:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallLikes") { result in
            
            eventlikes = result.object![3] as! String
            print(eventlikes)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = eventlikes
            
        }
        
        mainWall.likesQuery()
        
    }
    
    func eventCM(label:UILabel){
        
        var eventComments:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallComments") { result in
            
            eventComments = result.object![3] as! String
            print(eventComments)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = eventComments
            
        }
        
        mainWall.commentsQuery()
        
    }
    
    func profileName(label:UILabel){
        
        var eventprofileName:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallProfileName") { result in
            
            eventprofileName = result.object![3] as! String
            print(eventprofileName)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = eventprofileName
            
        }
        
        mainWall.profileNameQuery()
        
    }
    
    func eventAddress(button:UIButton){
        
        var address:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallAddress") { result in
            
            address = result.object![3] as! String
            print(address)
            button.setTitle(address, forState: UIControlState.Normal)
            
        }
        
        mainWall.eventAddressQuery()
        
    }
    
    //need to pass a refrence to a video player
    func eventVideo(){
        
        var video:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallVideo") { result in
            
            video = result.object![3] as! String
            let URL = NSURL(string: video)!
            
            print(URL)
            
        }
        
        mainWall.videoQuery()
        
    }
}

