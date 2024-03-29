//
//  Login.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class Login {
    
    let favorite = userFavorites()
    
    func userLogin(UserName:String,password:String){
    
        PFUser.logInWithUsernameInBackground(UserName, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                
                print("loged In")
                print("user is \(user!.username)")
                
                SwiftEventBus.post("login")
                
            } else {
                // The login failed. Check error to see why.
                
                //print(error?.localizedFailureReason)
                
                 SwiftEventBus.post("loginFailed")
            }
        }
    }
}