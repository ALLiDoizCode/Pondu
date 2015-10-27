//
//  ParseComments.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class comments {
    
    func userComment(postID:String){
        
        let bigObject:PFQuery! = PFQuery(className:"MainWall")
    
        bigObject.getObjectInBackgroundWithId(postID) { (object:PFObject?, error:NSError?) -> Void in
            
            if error != nil {
                print(error)
            } else if let _ = object{
                object!.addObject("Jerry", forKey: "Comments")
                object!.saveInBackground()
            }
            
        }
    }
    
}
