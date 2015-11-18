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

 ////////////////////////////////////Adding Favorite//////////////////////////////////////////////////
    func userFavorite(objectID:String){
        
        if var favList = currentUser!["Favorites"] as! [String]! {
            
            if currentUser != nil {
                
                var i:Int = Int()
                
                print("favlist count \(favList.count)")
                
                for i;(i < favList.count) && (objectID != favList[i]) ; i++ {
                    
                    print("I = \(i)")
                }
                
                
                //print("this is the favID \(favList[i])")
                //print("this is the objectID \(objectID)")
                
                
                if i >= favList.count {
                    
                    currentUser!.addObject(objectID, forKey: "Favorites")
                    print("favorite added")
                    currentUser?.saveInBackground()
                    
                }else{
                    
                    print("this favorite already exist")
                }
                
            } else {
                
                
            }
        }else{
            
            currentUser!.addObject(objectID, forKey: "Favorites")
            print("favorite added")
            currentUser?.saveInBackground()
        }
        
    }
    
    func userPartyFavorite(objectID:String){
        
        if var favList = currentUser!["partyFavorites"] as! [String]! {
            
            if currentUser != nil {
                
                var i:Int = Int()
                
                print("favlist count \(favList.count)")
                
                for i;(i < favList.count) && (objectID != favList[i]) ; i++ {
                    
                    print("I = \(i)")
                }
                
                
                //print("this is the favID \(favList[i])")
                //print("this is the objectID \(objectID)")
                
                
                if i >= favList.count {
                    
                    currentUser!.addObject(objectID, forKey: "partyFavorites")
                    print("favorite added")
                    currentUser?.saveInBackground()
                    
                }else{
                    
                    print("this partyFavorite already exist")
                }
                
            } else {
                
                
            }
        }else{
            
            currentUser!.addObject(objectID, forKey: "partyFavorites")
            print("partyFavorite added")
            currentUser?.saveInBackground()
        }
        
    }
    
    func userStoryFavorite(objectID:String){
        
        if var favList = currentUser!["FavStory"] as! [String]! {
            
            if currentUser != nil {
                
                var i:Int = Int()
                
                print("favlist count \(favList.count)")
                
                for i;(i < favList.count) && (objectID != favList[i]) ; i++ {
                    
                    print("I = \(i)")
                }
                
                
                
                
                if i >= favList.count {
                    
                    currentUser!.addObject(objectID, forKey: "FavStory")
                    print("favorite added")
                    currentUser?.saveInBackground()
                    
                }else{
                    
                    print("this FavStory already exist")
                }
                
            } else {
                
                
            }
        }else{
            
            currentUser!.addObject(objectID, forKey: "FavStory")
            print("FavStory added")
            currentUser?.saveInBackground()
        }
        
    }
 ////////////////////////////////////Adding Favorite Ends/////////////////////////////////////////////
    func favoriteList(){
        
        print("fav list fired")
        
        let fav = currentUser?.objectForKey("Favorites")
        
        print("sending fav id")
        
        print("user is \(currentUser?.username)")
        
        print(fav)
        
        SwiftEventBus.post("GetFavorites", sender: fav)
    }
    
    func partyFavoriteList(){
        
        print("fav list fired")
        
        let fav = currentUser?.objectForKey("Favorites")
        
        print("sending fav id")
        
        SwiftEventBus.post("partyGetFavorites", sender: fav)
    }
    
    func storyFavoriteList(){
        
        print("fav list fired")
        
        
        let fav = currentUser?.objectForKey("Favorites")
        
        print("sending fav id")
        
        SwiftEventBus.post("storyGetFavorites", sender: fav)
    }
}