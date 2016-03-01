//
//  Cloud.swift
//  Pondu
//
//  Created by Jonathan Green on 2/28/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class Cloud {
    
    let currentInstallation = PFInstallation.currentInstallation()
    let user = PFUser.currentUser()

    func addChannel(objectId:String){
        
        currentInstallation.addUniqueObject(objectId, forKey: "channels")
        currentInstallation.saveInBackground()
        
    }
    
    func removeChannel(objectId:String){
        
        currentInstallation.removeObject(objectId, forKey: "channels")
        currentInstallation.saveInBackground()
    }
    
    func pushComment(objectId:String){
        
        PFCloud.callFunctionInBackground("PushComment", withParameters: ["channel":objectId]) {
            (response: AnyObject?, error: NSError?) -> Void in
            
            if error != nil {
                
                print(error)
                
            }else {
                
                print("cloud code fired")
            }
        }
        
    }
}