//
//  Users.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus

class theUser {
    
    let client = UserClient()
    let Client2 = WallClient()
    
    func currentUser() -> KCSUser {
        
        let currentUser = client.currentUser()
        
        return currentUser
    }
    
    func getImage(completion:(data:NSURL) -> Void) {
        
        let imageID = currentUser().getValueForAttribute("ProfileImage") as! String
        
        Client2.getFile(imageID) { (data) in
            
            completion(data: data)
        }
    }
    
    func login(userName:String,passWord:String,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "login") { (notification) -> Void in
            
            completion(success: notification.object as! Bool)
        }
        
        client.login(userName, passWord: passWord)
    }
    
    func signUp(name:String,userName:String,passWord:String,email:String,profileImage:UIImage,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "signUp") { (notification) -> Void in
            
            completion(success: notification.object as! Bool)
        }
        
        client.signUp(name, userName: userName, passWord: passWord, email: email, profileImage: profileImage)
    }
    
    func deleteAccount(completion:(result:Bool) -> Void){
        
        client.delete { (result) in
            
            completion(result: result)
        }
    }
    
    func saveChanges( fullName:String!, userName:String!, email:String!, phone:String!, profileImage:UIImage!, bio:String!,completon:(result:Bool) -> Void) {
        
        client.userChanges(fullName, userName: userName, email: email, phone: phone, profileImage: profileImage, bio: bio) { (result) in
            
            completon(result: result)
        }
    }
    
    func resetPassWord(completion:(result:Bool) -> Void){
        
        client.resetPassword { (result) in
            
            completion(result: result)
        }
    }
    
    func forgotUserName(completion:(result:Bool) -> Void){
        
        client.forgotUsername { (result) in
            
            completion(result: result)
        }
    }
    
    func verify(){
        
        client.verifyUser()
    }
    
    func getUsers(completion:(users:[UserInfo]) -> Void){
        
        SwiftEventBus.onBackgroundThread(self, name: "User") { result in
            
            let data:[UserInfo] = (result.object as? [UserInfo])!
            
            SwiftEventBus.unregister(self, name: "User")
            
            completion(users: data)
        }
        
        client.getUsers()
        
    }
    
    func addUser(userName:String,completion:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "addUser") { (notification) -> Void in
            
            let result = notification.object as! Bool
            
            completion(success: result)
            
            SwiftEventBus.unregister("addUser")
        }
        
        client.addUser(userName)
    }
    
    func myFollow(completion:(data:[String]) -> Void){
        
        let following = client.currentUser().getValueForAttribute("Following") as! [String]
        
        completion(data: following)
        
    }
   
}
