//
//  ParseFavorite.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class Favorite {
    
    let currentUser = PFUser.currentUser()
    
    func userFavorite(objectID:String){
        
        if currentUser != nil {
            
             currentUser!.addObject(objectID, forKey: "Favorites")
            print("favorite added")
            currentUser?.saveInBackground()
            
        } else {
            

        }
        
    }
    
    func userPartyFavorite(objectID:String){
        
        if currentUser != nil {
            
            currentUser!.addObject(objectID, forKey: "partyFavorites")
            print("partyFavorites added")
            currentUser?.saveInBackground()
            
        } else {
            
            
        }
        
    }
    
    func favoriteList(){
        
        print("fav list fired")
        
        /*let currentUser = PFUser.currentUser()
        
        if currentUser != nil {
            
            let fav = currentUser!["Favorites"]
            
            SwiftEventBus.post("GetFavorites", sender: fav)
            
        } else {
            
            
        }*/
        
        let fav = currentUser?.objectForKey("Favorites")
        
        print("sending fav id")
        
        print("user is \(currentUser?.username)")
        
        print(fav)
        
        SwiftEventBus.post("GetFavorites", sender: fav)
    }
    
    func partyFavoriteList(){
        
        print("fav list fired")
        
        /*let currentUser = PFUser.currentUser()
        
        if currentUser != nil {
        
        let fav = currentUser!["Favorites"]
        
        SwiftEventBus.post("GetFavorites", sender: fav)
        
        } else {
        
        
        }*/
        
        let fav = currentUser?.objectForKey("partyFavorites") as! [String]
        
        print("sending fav id")
        
        SwiftEventBus.post("partyGetFavorites", sender: fav)
    }
}