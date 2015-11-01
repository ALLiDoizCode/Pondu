//
//  FavoriteParties.swift
//  Pondu
//
//  Created by Jonathan Green on 10/27/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher

class partyFavorites {
    
    let party = ParseParties()
    
    let mainWall = ParseMainWall()
    
    let thisFavorite = Favorite()
    
    func addFavorite(partyID:String){
        
        self.thisFavorite.userFavorite(partyID)
        print(partyID)
    }
    
    
    func getFavorite(){
        
        print("waiting for favParty ids")
        
        ///favorite id
        SwiftEventBus.onMainThread(self, name: "partyGetFavorites") { result in
            
            if let fav = result.object as! [String]!{
                
                print("getfavorites \(fav)")
                
                print("recieved fav id")
                print("sending fav id")
                self.party.postQuery(fav)
                //self.party.ImageQuery(fav)
                //self.party.ThumbQuery(fav)
                //self.party.likesQuery(fav)
                //self.party.commentsQuery(fav)
                //self.party.profileNameQuery(fav)
                //self.party.eventAddressQuery(fav)
                //self.party.videoQuery(fav)
                
                SwiftEventBus.unregister(self, name: "partyGetFavorites")
            }
            
        }
        
        favPost()
        //favIcon()
        //favAddress()
        //favCL()
        //favCM()
        //favprofileName()
        //favThumb()
        //favTime()
        //favVideo()
        
        thisFavorite.partyFavoriteList()
        
    }
    
    
    
    func favPost(){
        
        //gets list of favorites
        SwiftEventBus.onMainThread(self, name: "partyFavoritesList") { result in
            
            if let favList = result.object {
                
                print("recieved fav post")
                print("favList \(favList)")
                print("do something with post data")
                SwiftEventBus.postToMainThread("updateCell", sender: favList)
                SwiftEventBus.unregister(self, name: "partyFavoritesList")
            }
            
        }
        
    }
    
    
    func favIcon(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavImage") { result in
            
            let favImage = result.object as! [String]
            print("do something with favImage data")
            
            //imageView.kf_setImageWithURL(NSURL(string: favImage[0])!)
            SwiftEventBus.unregister(self, name: "partyfavImage")
        }
        
        
    }
    
    func favThumb(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavThumbImage") { result in
            
            let thumbImage = result.object as! [String]
            print(thumbImage)
            
            // imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            SwiftEventBus.unregister(self, name: "partyfavThumbImage")
        }
        
        
    }
    
    func favTime(){
        
        
    }
    
    func favCL(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavLikes") { result in
            
            let favlikes = result.object as! [String]
            print(favlikes)
            
            SwiftEventBus.unregister(self, name: "partyfavLikes")
        }
        
        
        
    }
    
    func favCM(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavComments") { result in
            
            let favComments = result.object as! [String]
            print(favComments)
            
            SwiftEventBus.unregister(self, name: "partyfavComments")
        }
        
        
        
    }
    
    func favprofileName(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavProfileName") { result in
            
            let favProfileName = result.object as! [String]
            print(favProfileName)
            SwiftEventBus.unregister(self, name: "partyfavProfileName")
        }
        
        
        
    }
    
    func favAddress(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavAddress") { result in
            
            let address = result.object as! [String]
            print(address)
            //button.setTitle(address, forState: UIControlState.Normal)
            SwiftEventBus.unregister(self, name: "partyfavAddress")
        }
        
        
        
    }
    
    //need to pass a refrence to a video player
    func favVideo(){
        
        SwiftEventBus.onMainThread(self, name: "partyfavVideo") { result in
            
            let video = result.object as! [String]
            print(video)
            //let URL = NSURL(string: video)!
            
            //print(URL)
            SwiftEventBus.unregister(self, name: "partyfavVideo")
            
        }
        
        
        
    }
}

