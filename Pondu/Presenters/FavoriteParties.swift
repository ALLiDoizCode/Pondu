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
                
                SwiftEventBus.unregister(self, name: "partyGetFavorites")
            }
            
        }
        
        favPost()
        
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
    
}

