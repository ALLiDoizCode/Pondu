//
//  UserClient.swift
//  Pondu
//
//  Created by Jonathan Green on 3/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation


class UserClient {
    
    func signUp(name:String,userName:String,passWord:String,email:String,profileImage:UIImage){
        
        // Create a new user with the username 'kinvey' and the password '12345'
        KCSUser.userWithUsername(
            userName,
            password: passWord,
            fieldsAndValues: [
                KCSUserAttributeEmail : email,
                KCSUserAttributeGivenname : name,
            ],
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //user is created
                    
                    self.verifyUser()
                    
                } else {
                    //there was an error with the create
                }
            }
        )
    }
    
    func login(userName:String,passWord:String) {
        
        KCSUser.loginWithUsername(
            userName,
            password: passWord,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    
                    
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Create account failed", comment: "Sign account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                }
            }
        )
    }
    
    func signOut(){
        
        // Logout the active user
        KCSUser.activeUser().logout()
    }
    
    func delete(){
        
        KCSUser.activeUser().removeWithCompletionBlock { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
            if errorOrNil != nil {
                NSLog("error %@ when deleting active user", errorOrNil)
            } else {
                NSLog("active user deleted")
            }
        }
    }
    
    func resetPassword(){
        
        KCSUser.sendPasswordResetForUser(
             KCSUser.activeUser().email,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                // handle error
            }
        )
    }
    
    func forgotUsername(){
        
        KCSUser.sendForgotUsername(
            KCSUser.activeUser().email,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                //display success or error
            }
        )
    }
    
    func verifyUser(){
        
        let activeUser = KCSUser.activeUser()
        KCSUser.sendEmailConfirmationForUser(
            activeUser.username,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //handle error
                } // not much to do on success, for most apps
            }
        )
    }
}