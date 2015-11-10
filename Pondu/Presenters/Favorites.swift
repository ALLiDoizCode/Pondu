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
           
                
                SwiftEventBus.unregister(self, name: "GetFavorites")
            }
           
        }
        
        favPost()
        
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
                SwiftEventBus.postToMainThread("updateFavoriteCell", sender: favList)
                
                SwiftEventBus.unregister(self, name: "FavoritesList")
            }
            
        }

    }

}
