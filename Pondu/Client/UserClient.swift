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
    
    func currentUser() -> KCSUser {
        
        let activeUser = KCSUser.activeUser()
        
        return activeUser
    }
    
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
    
    func addUser(userName:String) {
            
        var following = currentUser().getValueForAttribute("Following") as! [String]
            
        if following.contains(userName) {
                
            print("alreadying following \(userName)")
        }else {
            
            following.append(userName)
            currentUser().setValue(following, forAttribute: "Following")
            
            currentUser().saveWithCompletionBlock({ (objects, error) in
                
                if error == nil {
                    
                    print("updated user Sucess")
                    
                    SwiftEventBus.post("addUser", sender: true)
                }else {
                    
                    print("updated user failed")
                    
                    SwiftEventBus.post("addUser", sender: false)
                }
            })
            
        }
        
        
    }
    
    func userChanges(var fullName:String!,var userName:String!,var email:String!,var phone:String!,var profileImage:UIImage!,var bio:String!,completion:(result:Bool) -> Void) {
        
        if fullName == nil {
            var currentName:String!
            
            currentName = self.currentUser().getValueForAttribute("first_name") as! String
            
            if currentName != nil {
                
                fullName = currentName
            }else {
                
                fullName = ""
            }
            
            
        }
        
        if userName == nil {
            
            userName = self.currentUser().username
        }
        
        if email == nil {
            
            email = self.currentUser().email
        }
        
        if phone == nil {
            
            var currentPhone:String!
            
            currentPhone = self.currentUser().getValueForAttribute("Phone") as! String
            
            if currentPhone != nil {
                
                phone = currentPhone
                
            }else {
                
                phone = ""
            }
        }
        
        if bio == nil {
        
            var currentBio:String!
            
            currentBio = self.currentUser().getValueForAttribute("Bio") as! String
            
            if currentBio != nil  {
                
                bio = currentBio
                
            }else {
                
                bio = ""
            }
        }
        
        if profileImage == nil {
            
            if userName == self.currentUser().username || userName == "" {
                
                self.currentUser().email = email
                self.currentUser().setValue(fullName, forAttribute: "first_name")
                self.currentUser().setValue(bio, forAttribute: "Bio")
                self.currentUser().setValue(phone, forAttribute: "Phone")
                
            }else {
                
                self.currentUser().email = email
                self.currentUser().username = userName
                self.currentUser().setValue(fullName, forAttribute: "first_name")
                self.currentUser().setValue(bio, forAttribute: "Bio")
                self.currentUser().setValue(phone, forAttribute: "Phone")
            }
            
           
            
            self.currentUser().saveWithCompletionBlock({ (objets, error) in
                
                if error == nil {
                    
                    completion(result: true)
                }else {
                    
                    print(error)
                    
                    completion(result: false)
                }
            })
            
        }else {
            
            self.uploadPicture(profileImage, completion: { (file) in
                
                if userName == self.currentUser().username || userName == "" {
                    
                    self.currentUser().email = email
                    self.currentUser().setValue(file.fileId, forAttribute: "ProfileImage")
                    self.currentUser().setValue(fullName, forAttribute: "first_name")
                    self.currentUser().setValue(bio, forAttribute: "Bio")
                    self.currentUser().setValue(phone, forAttribute: "Phone")
                }else {
                    self.currentUser().email = email
                    self.currentUser().username = userName
                    self.currentUser().setValue(file.fileId, forAttribute: "ProfileImage")
                    self.currentUser().setValue(fullName, forAttribute: "first_name")
                    self.currentUser().setValue(bio, forAttribute: "Bio")
                    self.currentUser().setValue(phone, forAttribute: "Phone")
                }
                
                self.currentUser().saveWithCompletionBlock({ (objets, error) in
                    
                    if error == nil {
                        
                        completion(result: true)
                    }else {
                        
                        print(error)
                        completion(result: false)
                    }
                })
            
            })
        }
    }
    
    func signUp(name:String,userName:String,passWord:String,email:String,profileImage:UIImage,school:String){
        
        let follow:[String] = []
        let privateStatus:NSNumber = false
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
                    
                    self.uploadPicture(profileImage) { (file) in
                        
                        user.setValue(file.fileId, forAttribute: "ProfileImage")
                        user.setValue(follow, forAttribute: "Following")
                        user.setValue(privateStatus, forAttribute: "Private")
                        user.setValue(school, forAttribute: "School")
                        user.saveWithCompletionBlock({ (objects, error) in
                            
                            if error == nil {
                                
                                SwiftEventBus.post("signUp", sender: true)
                                self.verifyUser()
                                
                                
                            }else {
                                
                                SwiftEventBus.post("signUp", sender: false)
                                
                                
                            }
                        })
                        
                    }
                    
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
    func uploadPicture(photo:UIImage!,completion:(file:KCSFile!) -> ()) {
        
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
            
            let photoData = UIImageJPEGRepresentation(photo, 0.5)
            
            
            
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
    
    func signOut(completion:(result:Bool) -> Void){
        
        // Logout the active user
        KCSUser.activeUser().logout()
        completion(result:true)
    }
    
    func delete(completion:(result:Bool) -> Void){
        
        KCSUser.activeUser().removeWithCompletionBlock { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
            if errorOrNil != nil {
                NSLog("error %@ when deleting active user", errorOrNil)
            } else {
                completion(result:true)
                NSLog("active user deleted")
            }
        }
    }
    
    func resetPassword(completion:(result:Bool) -> Void){
        
        KCSUser.sendPasswordResetForUser(
             KCSUser.activeUser().email,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                // handle error
                completion(result: emailSent)
            }
        )
    }
    
    func forgotUsername(completion:(result:Bool) -> Void){
        
        KCSUser.sendForgotUsername(
            KCSUser.activeUser().email,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                //display success or error
                
                completion(result: emailSent)
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