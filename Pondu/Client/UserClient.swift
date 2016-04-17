//
//  UserClient.swift
//  Pondu
//
//  Created by Jonathan Green on 3/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class UserClient {
    
    
    func getUsers(){
        
        var users:[UserInfo] = []
        
        let collection = KCSCollection.userCollection()
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.queryWithQuery(KCSQuery(), withCompletionBlock: { (objects: [AnyObject]!, error: NSError!) -> Void in
            //objectsOrNil is a list of users
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let user = object as! KCSUser
                        
                        let userName = user.username
                        if  user.getValueForAttribute("ProfileImage") != nil {
                            
                            let proifleImage:String! = user.getValueForAttribute("ProfileImage") as!String
                            
                            print(userName)
                            print(proifleImage)
                            
                            let theUser = UserInfo(theUserName: userName, theProfileImage: proifleImage)
                            
                            users.append(theUser)
                        }
                
                    }
                    
                    SwiftEventBus.post("User", sender: users)
                }
                
            }else {
                
            }
            
            
            }, withProgressBlock: nil)
    
    }
    
    func signUp(name:String,userName:String,passWord:String,email:String,profileImage:UIImage){
        
        self.uploadProfilePicture(profileImage) { (file) in
            
            // Create a new user with the username and the password
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
                        
                        user.setValue(file.fileId, forAttribute: "ProfileImage")
                        user.saveWithCompletionBlock({ (objects, error) in
                            
                            if error == nil {
                                
                                SwiftEventBus.post("signUp", sender: true)
                                self.verifyUser()

                                
                            }else {
                                
                                SwiftEventBus.post("signUp", sender: false)
        

                            }
                        })
                        
                    } else {
                        //there was an error with the create
                    }
                }
            )
        }
        
    }
    
    func login(userName:String,passWord:String) {
        
        KCSUser.loginWithUsername(
            userName,
            password: passWord,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    
                    SwiftEventBus.post("login", sender: true)
                    
                    
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
    
    // Upload the profile picture to the Kinvey file store
    func uploadProfilePicture(photo:UIImage!,completion:(file:KCSFile!) -> ()) {
        
        // Initialize with the default initializer
        let metadata = KCSMetadata();
        
        // Ensure that all users can access this file
        metadata.setGloballyReadable(true);
        
        // This is added to a params object that is passed to the upload data method
        let fileParams = [
            KCSFileMimeType : "image/jpeg",
            KCSFileACL : metadata
        ];
        
        if(photo != nil) {
            let photoData = UIImageJPEGRepresentation(photo, 0.6)
            
            KCSFileStore.uploadData(photoData, options: fileParams, completionBlock: { (file:KCSFile!, error:NSError!) -> Void in
                
                if error == nil {
                    
                    print("successfully uploaded image")
                    completion(file: file);
                    
                }else {
                    print("the error is\(error)")
                }
                
                
            }, progressBlock: nil);
            
        } else {
            
            print("failed to upload image")
            completion(file: nil);
        }
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