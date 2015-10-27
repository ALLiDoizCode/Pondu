//
//  Favorites.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class userFavorites {
    
    let mainWall = ParseMainWall()
    
    let thisFavorite = Favorite()
    
    func makeComment(index:int){
     
        SwiftEventBus.onMainThread(self, name: "Favorite") { result in
            
            let objectID = result.object
            print(objectID)
            
            thisFavorite.userFavorite(objectID[index])
        }
        
        mainWall.idQuery()
    }
}
