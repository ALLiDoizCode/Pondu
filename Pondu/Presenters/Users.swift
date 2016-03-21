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
    
    func editProfile(name:String,userName:String,email:String,phone:String,bio:String){
        
        user.saveUserInfo(name, userName: userName, email: email, phone: phone, bio: bio)
    }
    
    func changePassWord(email:String){
        
        user.savePassWord(email)
    }
    
    func getUsers(completion:(users:[userData]) -> Void){
        
        SwiftEventBus.onBackgroundThread(self, name: "User") { result in
            
            let data:[userData] = (result.object as? [userData])!
            
            
            SwiftEventBus.unregister(self, name: "User")
            
            completion(users: data)
        }
        
        user.userQuery()
    }
    
    func addUser(objectId:String,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "addUser") { (notification) -> Void in
            
            let result = notification.object as! Bool
            
            completion(success: result)
            
            SwiftEventBus.unregister("addUser")
        }
        
        user.follow(objectId)
    }
   
}
