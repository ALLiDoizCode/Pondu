//
//  ParseMainWall.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse


func testQuery(){
    
    let query = PFQuery(className:"MainWall")
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        
        if error == nil {
            // The find succeeded.
            print("Successfully retrieved \(objects!.count) names.")
            
            // Do something with the found objects
            if let objects = objects {
                for object in objects {
                    
                    let name = object.objectForKey("Name")
                    print(name)
                }
            }
        } else {
            // Log details of the failure
            print("Error: \(error!) \(error!.userInfo)")
        }
    }
}