//
//  userLogin.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class startLogin {
    
    let userlogin = Login()
    
    func beginLogin(UserName: String, password: String){
        
        userlogin.userLogin(UserName, password)
    }
}


