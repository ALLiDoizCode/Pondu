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
    
    func theUsers(){
        
        SwiftEventBus.onMainThread(self, name: "User") { result in
            
            let bio = result.object
            print(bio)
            
        }
        
        user.userQuery()
        
    }
    
    
   
}
