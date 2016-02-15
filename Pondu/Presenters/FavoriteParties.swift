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
    
    
    func favPost(){
        
        //gets list of favorites
        SwiftEventBus.onMainThread(self, name: "partyFavoritesList") { result in
            
            if let favList = result.object {
                
                print("recieved fav post")
                print("favList \(favList)")
                print("do something with post data")
                SwiftEventBus.postToMainThread("updateFavoritePartyCell", sender: favList)
                SwiftEventBus.unregister(self, name: "partyFavoritesList")
            }
            
        }
        
        party.favParties()
    }
    
}

