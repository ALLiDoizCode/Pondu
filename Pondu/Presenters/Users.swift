//
//  Users.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class theUser {
    
    let user = parseUser()
    let nilArray:[String]! = nil
    let thisFavorite = Favorite()
    
    func theUsers(Completion:(([userData])->Void)){
        
        SwiftEventBus.onMainThread(self, name: "User") { result in
            
            let theData = result.object
            print(theData)
            
            //SwiftEventBus.postToMainThread("updateStory", sender: theData)
            Completion(theData as! [userData])
        }
        
        user.userQuery(nilArray)
        
    }
    
    func getFavorite(){
        
        print("waiting for favParty ids")
        
        ///favorite id
        SwiftEventBus.onMainThread(self, name: "storyGetFavorites") { result in
            
            if let fav = result.object as! [String]!{
                
                print("getfavorites \(fav)")
                
                print("recieved fav id")
                print("sending fav id")
                self.user.userQuery(fav)
                
                SwiftEventBus.unregister(self, name: "storyGetFavorites")
            }
            
        }
        
        userFavStory()
        
        thisFavorite.storyFavoriteList()
        
    }
    
    func userFavStory(){
        
        SwiftEventBus.onMainThread(self, name: "FavUser") { result in
            
            let userData = result.object
            print(userData)
            
            SwiftEventBus.postToMainThread("updateFavStory", sender: userData)
            
        }

    }
    
    func editProfile(name:String,userName:String,email:String,phone:String,bio:String){
        
        user.saveUserInfo(name, userName: userName, email: email, phone: phone, bio: bio)
    }
    
    func changePassWord(email:String){
        
        user.savePassWord(email)
    }
    
    
   
}
