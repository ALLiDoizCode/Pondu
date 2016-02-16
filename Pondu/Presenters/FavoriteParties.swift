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
    
    let fav = ParseParties()
    
    func favPost(completion:(result:[Event]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "MainWallEvent") { result in
            
            if let data:[Event] = result.object as? [Event] {
                
                SwiftEventBus.unregister(self, name: "MainWallEvent")
                completion(result: data)
            }
            
            

            
        }
        
       fav.favParties()
        
    }
    
}

