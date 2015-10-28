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
    
    func addFavorite(index:Int){
     
        SwiftEventBus.onMainThread(self, name: "Favorite") { result in
            
            let objectID = result.object
            print("favorite id \(objectID)")
            
            self.thisFavorite.userFavorite(objectID![index] as! String)
            SwiftEventBus.unregister(self, name: "Favorite")
        }
        
        mainWall.idQuery()
    }
    
    
    func getFavorite(label:UILabel,imageView:UIImageView){
        
        print("waiting for fav ids")
        
        ///favorite id
        SwiftEventBus.onMainThread(self, name: "GetFavorites") { result in
            
            if let fav = result.object as! [String]!{
                
                print("getfavorites \(fav[0])")
                
                print("recieved fav id")
                print("sending fav id")
                self.mainWall.postQuery(fav)
                self.mainWall.ImageQuery(fav)
                self.mainWall.ThumbQuery(fav)
                self.mainWall.likesQuery(fav)
                self.mainWall.commentsQuery(fav)
                self.mainWall.profileNameQuery(fav)
                self.mainWall.eventAddressQuery(fav)
                self.mainWall.videoQuery(fav)
                
                SwiftEventBus.unregister(self, name: "GetFavorites")
            }
           
        }
        
        favPost(label)
        favIcon(imageView)
        
        thisFavorite.favoriteList()
        
    }
    
    
    
    func favPost(label:UILabel){
        
        //gets list of favorites
        SwiftEventBus.onMainThread(self, name: "FavoritesList") { result in
            
            if let favList = result.object as! [String]!{
                
                print("recieved fav post")
                print("favList \(favList[0])")
                print("do something with post data")
                label.text = favList[0]
                
                SwiftEventBus.unregister(self, name: "FavoritesList")
            }
            
        }

    }

    
    func favIcon(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "favImage") { result in
            
            let favImage = result.object as! [String]
            print("do something with favImage data")
            
            imageView.kf_setImageWithURL(NSURL(string: favImage[0])!)
            SwiftEventBus.unregister(self, name: "favImage")
        }
        
        
    }
    
    func favThumb(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "favThumbImage") { result in
            
            let thumbImage = result.object as! [String]
            print(thumbImage)
            
            // imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            
        }
        
       
    }
    
    func favTime(){
        
        
    }
    
    func favCL(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "favLikes") { result in
            
            let favlikes = result.object
            print(favlikes)
            
        }
        
        
        
    }
    
    func favCM(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "favComments") { result in
            
            let favComments = result.object
            print(favComments)
            
        }
        
        
        
    }
    
    func favprofileName(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "favProfileName") { result in
            
            let favProfileName = result.object
            print(favProfileName)
            
        }
        
        
        
    }
    
    func favAddress(button:UIButton){
        
        SwiftEventBus.onMainThread(self, name: "favAddress") { result in
            
            let address = result.object
            print(address)
            //button.setTitle(address, forState: UIControlState.Normal)
            
        }
        
        
        
    }
    
    //need to pass a refrence to a video player
    func favVideo(){
        
        SwiftEventBus.onMainThread(self, name: "favVideo") { result in
            
            let video = result.object
            print(video)
            //let URL = NSURL(string: video)!
            
            //print(URL)
            
        }
        
        
        
    }
}
