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
    let nilArray:[String]! = nil
    
    func partiesPost(){
        
        SwiftEventBus.onMainThread(self, name: "PartyEvent") { result in
            
            let post = result.object 
            print(post)
            SwiftEventBus.postToMainThread("updatePartyCell", sender: post)
            SwiftEventBus.unregister(self, name: "PartyEvent")
            
        }
        
        Parties.postQuery(nilArray)
        
    }
    
    
    
}
