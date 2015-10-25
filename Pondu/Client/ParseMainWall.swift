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



class ParseMainWall {
    
    let Presenter = PresentMainWall()
    
            func testQuery(){
                
                var EventName:[String] = []
                self.Presenter.eventDescription()
                
                let query = PFQuery(className:"MainWall")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) names.")
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                
                                let name = object.objectForKey("Name") as! String
                                //print(name)
                                
                                EventName.append(name)
                            }
                            
                            SwiftEventBus.post("MainWallEvent", sender: EventName)
                            
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }

}

