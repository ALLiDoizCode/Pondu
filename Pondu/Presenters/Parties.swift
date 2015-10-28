//
//  Parties.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class PartiesMainWall {
    
    let Parties = ParseParties()
    let nilArray:[String]! = nil
    
    func partiesPost(label: UILabel){
        
        SwiftEventBus.onMainThread(self, name: "PartyEvent") { result in
            
            
            let post = result.object
            print(post)
            
            SwiftEventBus.unregister(self, name: "PartyEvent")
            
        }
        
        Parties.postQuery(nilArray)
        
    }
    
    
    func partiesIcon(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "PartiesImage") { result in
            
           let partiesImage = result.object
            print(partiesImage)
            
            //imageView.kf_setImageWithURL(NSURL(string: partiesImage)!)
            SwiftEventBus.unregister(self, name: "PartiesImage")
        }
        
        Parties.ImageQuery(nilArray)
    }
    
    func partiesThumb(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "PartiesThumbImage") { result in
            
            let thumbImage = result.object
            print(thumbImage)
            
            //imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            SwiftEventBus.unregister(self, name: "PartiesThumbImage")
        }
        
        Parties.ThumbQuery(nilArray)
    }
    
    func eventTime(){
        
        
    }
    
    func partiesCL(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "PartiesLikes") { result in
            
           let partieslikes = result.object
            print(partieslikes)
            SwiftEventBus.unregister(self, name: "PartiesLikes")
    }
        
        Parties.likesQuery(nilArray)
        
    }
    
    func partiesCM(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "PartiesComments") { result in
            
            let partiesComments = result.object
            print(partiesComments)
            SwiftEventBus.unregister(self, name: "PartiesComments")
    }
        
        Parties.commentsQuery(nilArray)
        
    }
    
    func partiesName(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "PartiesProfileName") { result in
            
           let partiesprofileName = result.object!
            print(partiesprofileName)
            SwiftEventBus.unregister(self, name: "PartiesProfileName")
            
        }
        
        Parties.profileNameQuery(nilArray)
        
    }
    
    func partiesAddress(button:UIButton){
        
        SwiftEventBus.onMainThread(self, name: "PartiesAddress") { result in
            
            let address = result.object
            print(address)
            //button.setTitle(address, forState: UIControlState.Normal)
            SwiftEventBus.unregister(self, name: "PartiesAddress")
        }
        
        Parties.eventAddressQuery(nilArray)
        
    }
    
    //need to pass a refrence to a video player
    func partiesVideo(){
        
        SwiftEventBus.onMainThread(self, name: "PartiesVideo") { result in
            
            let video = result.object
            print(video)
            //let URL = NSURL(string: video)!
            
            //print(URL)
            SwiftEventBus.unregister(self, name: "PartiesVideo")
        }
        
        Parties.videoQuery(nilArray)
        
    }
}
