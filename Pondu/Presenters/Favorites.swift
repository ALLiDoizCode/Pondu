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
        
        //gets list of favorites
        SwiftEventBus.onMainThread(self, name: "FavoritesList") { result in
            
            if let favList = result.object as! [String]!{
                
                print("recieved fav post")
                print("favList \(favList[0])")
                print("do something with post data")
                
                SwiftEventBus.unregister(self, name: "FavoritesList")
            }
            
        }
        
        thisFavorite.favoriteList()
        
    }
}
