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
    
    func partiesPost(completion:(result:[Event]) -> Void){
        
        let Parties = ParseParties()
        
        SwiftEventBus.onMainThread(self, name: "PartyEvent") { result in
            
            let post:[Event] = (result.object as? [Event])!
            print(post)
            
            SwiftEventBus.unregister(self, name: "PartyEvent")
            completion(result: post)
            
            
            
        }
        
        Parties.postQuery()
        
    }
    
    
    
}
