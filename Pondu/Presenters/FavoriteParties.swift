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
    
    let mainWall = ParseMainWall()
    
    let thisFavorite = Favorite()
    
    func addFavorite(index:Int){
        
        SwiftEventBus.onMainThread(self, name: "partyFavorite") { result in
            
            let objectID = result.object
            print("favorite id \(objectID)")
            
            self.thisFavorite.userFavorite(objectID![index] as! String)
            SwiftEventBus.unregister(self, name: "partyFavorite")
        }
        
        mainWall.idQuery()
    }
    
    
    func getFavorite(postlabel:UILabel,icon:UIImageView,likes:UILabel,comments:UILabel,name:UILabel){
        
        print("waiting for fav ids")
        
        ///favorite id
        SwiftEventBus.onMainThread(self, name: "partyGetFavorites") { result in
            
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
                
                SwiftEventBus.unregister(self, name: "partyGetFavorites")
            }
            
        }
        
        favPost(postlabel)
        favIcon(icon)
        //favAddress(<#T##button: UIButton##UIButton#>)
        favCL(likes)
        favCM(comments)
        favprofileName(name)
        //favThumb(<#T##imageView: UIImageView##UIImageView#>)
        //favTime()
        //favVideo()
        
        thisFavorite.favoriteList()
        
    }
    
    
    
    func favPost(label:UILabel){
        
        //gets list of favorites
        SwiftEventBus.onMainThread(self, name: "partyFavoritesList") { result in
            
            if let favList = result.object as! [String]!{
                
                print("recieved fav post")
                print("favList \(favList[0])")
                print("do something with post data")
                label.text = favList[0]
                
                SwiftEventBus.unregister(self, name: "partyFavoritesList")
            }
            
        }
        
    }
    
    
    func favIcon(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "partyfavImage") { result in
            
            let favImage = result.object as! [String]
            print("do something with favImage data")
            
            imageView.kf_setImageWithURL(NSURL(string: favImage[0])!)
            SwiftEventBus.unregister(self, name: "partyfavImage")
        }
        
        
    }
    
    func favThumb(imageView:UIImageView){
        
        SwiftEventBus.onMainThread(self, name: "partyfavThumbImage") { result in
            
            let thumbImage = result.object as! [String]
            print(thumbImage)
            
            // imageView.kf_setImageWithURL(NSURL(string: thumbImage)!)
            SwiftEventBus.unregister(self, name: "partyfavThumbImage")
        }
        
        
    }
    
    func favTime(){
        
        
    }
    
    func favCL(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "partyfavLikes") { result in
            
            let favlikes = result.object as! [String]
            print(favlikes)
            
            label.text = favlikes[0]
            SwiftEventBus.unregister(self, name: "partyfavLikes")
        }
        
        
        
    }
    
    func favCM(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "partyfavComments") { result in
            
            let favComments = result.object as! [String]
            print(favComments)
            
            label.text = favComments[0]
            SwiftEventBus.unregister(self, name: "partyfavComments")
        }
        
        
        
    }
    
    func favprofileName(label:UILabel){
        
        SwiftEventBus.onMainThread(self, name: "partyfavProfileName") { result in
            
            let favProfileName = result.object as! [String]
            print(favProfileName)
            label.text = favProfileName[0]
            SwiftEventBus.unregister(self, name: "partyfavProfileName")
        }
        
        
        
    }
    
    func favAddress(button:UIButton){
        
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

