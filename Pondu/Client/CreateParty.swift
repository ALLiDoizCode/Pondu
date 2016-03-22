//
//  CreateParty.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse


class createParty {
    
    func theParty(){
        
        let wall = PFObject(className: "MainWall")
        let comments = PFObject(className: "CommentTable")
        let liveContent = PFObject(className: "LiveContentTable")
        let party = PFObject(withoutDataWithClassName: "Parties", objectId: "BEqYGSwslT")
        let currentUser = PFUser.currentUser()
        
        SwiftEventBus.onMainThread(self, name: "makeParty") { result in
            
            let createdParty = result.object as! makeParty
            let location:PFGeoPoint = PFGeoPoint(latitude: createdParty.lat, longitude: createdParty.long)
            
            wall["CreatedBy"] = currentUser
            wall["Post"] = createdParty.post
            wall["Name"] = createdParty.name
            wall["Live"] = createdParty.live
            wall["Address"] = createdParty.address
            wall["location"] = location
            wall["Likes"] = 0
            wall["Privacy"] = createdParty.privacy
            
            wall.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    
                    let relation = party.relationForKey("Parties")
                    relation.addObject(wall)
                    
                    party.saveInBackgroundWithBlock({ (sucess:Bool, error:NSError?) -> Void in
                        
                        if success {
                            
                            print("wall ID is \(wall.objectId)")
                            
                            comments["CreatedBy"] = wall
                            liveContent["CreatedBy"] = wall
                            
                            
                            comments.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                
                                if success {
                                    
                                    print("comments ID is \(comments.objectId)")
                                    
                                    wall["Comments"] = comments
                                    
                                    
                                    liveContent.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                        
                                        if success {
                                            
                                            print("liveContent ID is \(liveContent.objectId)")
                                            
                                            wall["LiveContent"] = liveContent
                                            
                                            wall.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                                
                                                if success {
                                                    
                                                    print("party made")
                                                    
                                                    SwiftEventBus.post("PartyMade")
                                                }
                                            })
                                            
                                        }
                                        
                                    })
                                    
                                    
                                }
                                
                            })
                        }
                        
                    })
                    
                } else {
                    // There was a problem, check error.description
                    
                    print("there was an issue creating the party")
                    SwiftEventBus.post("PartyNotMade")
                }
            }
        }
        
        
    }

}

