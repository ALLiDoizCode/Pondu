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
    
    func addFavorite(index:Int){
     
        SwiftEventBus.onMainThread(self, name: "Favorite") { result in
            
            let objectID = result.object
            print("favorite \(objectID)")
            
            self.thisFavorite.userFavorite(objectID![index] as! String)
            SwiftEventBus.unregister(self, name: "Favorite")
        }
        
        mainWall.idQuery()
    }
}
