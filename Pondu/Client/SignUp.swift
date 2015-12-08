//
//  SignUp.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class userSignUp {
    
    func SignUp(area:String,fullName:String,userName:String,password:String,Bio:String,email:String,phone:String,photo:UIImage,stories:UIImage){
        
        let photoData = UIImagePNGRepresentation(photo)
        let photoFile = PFFile(name:"photo", data:photoData!)
        
        let storyData = UIImagePNGRepresentation(stories)
        let storyFile = PFFile(name:"story", data:storyData!)
        
        let user = PFUser()
        user.username = userName
        user.password = password
        user.email = email
        // other fields can be set just like with PFObject
        user["Phone"] = phone
        user["Area"] = area
        user["FullName"] = fullName
        user["Bio"] = Bio
        user["Stories"] = storyFile
        user["photo"] = photoFile
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                
                print("signUp Success")
                
                SwiftEventBus.post("SignUP")
                
                // Hooray! Let them use the app now.
            }
        }
    }
}


