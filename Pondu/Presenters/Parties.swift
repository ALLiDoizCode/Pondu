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
    
    func partiesPost(label: UILabel){
        
        
        var post:String = String()
        
        SwiftEventBus.onMainThread(self, name: "MainWallParties") { result in
            
            post = result.object![1] as! String
            print(post)
            
            label.text = post
            
        }
        
        Parties.postQuery()
        
    }
    
    
    func partiesIcon(imageView:UIImageView){
        
        var partiesImage:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesImage") { result in
            
           partiesImage = result.object![3] as! String
            print(partiesImage)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            imageView.kf_setImageWithURL(NSURL(string: partiesImage)!)
            
        }
        
        Parties.ImageQuery()
    }
    
    func partiesThumb(imageView:UIImageView){
        
        var thumbImage:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesThumbImage") { result in
            
            thumbImage = result.object![0] as! String
            print(thumbImage)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            
        }
        
        Parties.ThumbQuery()
    }
    
    func eventTime(){
        
        
    }
    
    func partiesCL(label:UILabel){
        
        var partieslikes:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesLikes") { result in
            
           partieslikes = result.object![3] as! String
            print(partieslikes)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = partieslikes
            
        }
        
        Parties.likesQuery()
        
    }
    
    func partiesCM(label:UILabel){
        
        var partiesComments:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesComments") { result in
            
            partiesComments = result.object![3] as! String
            print(partiesComments)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = partiesComments
            
        }
        
        Parties.commentsQuery()
        
    }
    
    func partiesName(label:UILabel){
        
        var partiesprofileName:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesProfileName") { result in
            
           partiesprofileName = result.object![3] as! String
            print(partiesprofileName)
            
            //let URL = NSURL(string: eventImage)!
            
            //print(URL)
            
            label.text = partiesprofileName
            
        }
        
        Parties.profileNameQuery()
        
    }
    
    func partiesAddress(button:UIButton){
        
        var address:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesAddress") { result in
            
            address = result.object![3] as! String
            print(address)
            button.setTitle(address, forState: UIControlState.Normal)
            
        }
        
        Parties.eventAddressQuery()
        
    }
    
    //need to pass a refrence to a video player
    func partiesVideo(){
        
        var video:String = String()
        
        SwiftEventBus.onMainThread(self, name: "PartiesVideo") { result in
            
            video = result.object![3] as! String
            let URL = NSURL(string: video)!
            
            print(URL)
            
        }
        
        Parties.videoQuery()
        
    }
}
