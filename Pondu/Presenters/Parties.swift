//
//  Parties.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class PartiesMainWall {
    
    let Parties = ParseParties()
    
    func partiesPost(completion:(result:[Event]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "PartyEvent") { result in
            
            let post:[Event] = (result.object as? [Event])!
            print(post)
            
            SwiftEventBus.unregister(self, name: "PartyEvent")
            completion(result: post)
            
        }
        
        Parties.postQuery()
        
    }
    
    func favPost(completion:(result:[Event]) -> Void){
        
        let fav = ParseParties()
        
        SwiftEventBus.onMainThread(self, name: "FavoriteParties") { result in
            
            let post:[Event] = (result.object as? [Event])!
            print(post)
            
            SwiftEventBus.unregister(self, name: "FavoriteParties")
            completion(result: post)
            
        }
        
        fav.favParties()
        
    }
    
}
