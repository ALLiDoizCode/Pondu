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
    
    func userFavorite(objectID:String){
        
        
        let currentUser = PFUser.currentUser()
        
        if currentUser != nil {
            
             currentUser!.addObject(objectID, forKey: "Favorites")
            print("favorite added")
            currentUser?.saveInBackground()
            
        } else {
            

        }
        
    }
    
    func userPartyFavorite(objectID:String){
        
        
        let currentUser = PFUser.currentUser()
        
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
        
        let fav = ["LoFVItdb2n","RO79eVGFgX"]
        
        print("sending fav id")
        
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
        
        let fav = ["ccBnnB6g3Q","8wrbihD723"]
        
        print("sending fav id")
        
        SwiftEventBus.post("partyGetFavorites", sender: fav)
    }
}