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
    
    
    func editProfile(name:String,userName:String,email:String,phone:String,bio:String){
        
        user.saveUserInfo(name, userName: userName, email: email, phone: phone, bio: bio)
    }
    
    func changePassWord(email:String){
        
        user.savePassWord(email)
    }
    
    
   
}
