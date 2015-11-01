//
//  Favorites.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher

class userFavorites {
    
    let mainWall = ParseMainWall()
    
    let thisFavorite = Favorite()
    
    func addFavorite(eventID:String){
     
        self.thisFavorite.userFavorite(eventID)
        
        print(eventID)
        
    }
    
    
    func getFavorite(){
        
        print("waiting for fav ids")
        
        ///favorite id
        SwiftEventBus.onMainThread(self, name: "GetFavorites") { result in
            
            if let fav = result.object as! [String]!{
                
                print("getfavorites \(fav[0])")
                
                print("recieved fav id")
                print("sending fav id")
                self.mainWall.postQuery(fav)
                //self.mainWall.ImageQuery(fav)
                //self.mainWall.ThumbQuery(fav)
                //self.mainWall.likesQuery(fav)
                //self.mainWall.commentsQuery(fav)
                //self.mainWall.profileNameQuery(fav)
                //self.mainWall.eventAddressQuery(fav)
                //self.mainWall.videoQuery(fav)
                
                SwiftEventBus.unregister(self, name: "GetFavorites")
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
        
        thisFavorite.favoriteList()
        
    }
    
    
    
    func favPost(){
        
        //gets list of favorites
        SwiftEventBus.onBackgroundThread(self, name: "FavoritesList") { result in
            
            if let favList = result.object {
                
                print("recieved fav post")
                print("favList \(favList)")
                print("do something with post data")
                //label.text = favList[0]
                SwiftEventBus.post("Count", sender: favList.count )
                SwiftEventBus.postToMainThread("updateCell", sender: favList)
                
                SwiftEventBus.unregister(self, name: "FavoritesList")
            }
            
        }

    }

    
    func favIcon(){
        
        SwiftEventBus.onMainThread(self, name: "favImage") { result in
            
            let favImage = result.object as! [String]
            print("do something with favImage data")
            
            //imageView.kf_setImageWithURL(NSURL(string: favImage[0])!)
            SwiftEventBus.unregister(self, name: "favImage")
        }
        
        
    }
    
    func favThumb(){
        
        SwiftEventBus.onMainThread(self, name: "favThumbImage") { result in
            
            let thumbImage = result.object as! [String]
            print(thumbImage)
            
            // imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            SwiftEventBus.unregister(self, name: "favThumbImage")
        }
        
       
    }
    
    func favTime(){
        
        
    }
    
    func favCL(){
        
        SwiftEventBus.onMainThread(self, name: "favLikes") { result in
            
            let favlikes = result.object as! [String]
            print(favlikes)
            SwiftEventBus.unregister(self, name: "favLikes")
        }
        
        
        
    }
    
    func favCM(){
        
        SwiftEventBus.onMainThread(self, name: "favComments") { result in
            
            let favComments = result.object as! [String]
            print(favComments)
            SwiftEventBus.unregister(self, name: "favComments")
        }
        
        
        
    }
    
    func favprofileName(){
        
        SwiftEventBus.onMainThread(self, name: "favProfileName") { result in
            
            let favProfileName = result.object as! [String]
            print(favProfileName)
            SwiftEventBus.unregister(self, name: "favProfileName")
        }
        
        
        
    }
    
    func favAddress(){
        
        SwiftEventBus.onMainThread(self, name: "favAddress") { result in
            
            let address = result.object as! [String]
            print(address)
            //button.setTitle(address, forState: UIControlState.Normal)
            SwiftEventBus.unregister(self, name: "favAddress")
        }
        
        
        
    }
    
    //need to pass a refrence to a video player
    func favVideo(){
        
        SwiftEventBus.onMainThread(self, name: "favVideo") { result in
            
            let video = result.object as! [String]
            print(video)
            //let URL = NSURL(string: video)!
            
            //print(URL)
            SwiftEventBus.unregister(self, name: "favVideo")
        }
        
        
        
    }
}
