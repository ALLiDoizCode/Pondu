//
//  Messages.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse

class Messages {
    
    let currentUser = PFUser.currentUser()
    
    var lists:[Message]!
    var messages:[MessageList]!
    var listObject:[PFObject]!
    var messageObject:[PFObject]!
    
    func getMessages(){
        
        let listQuery = PFQuery(className: "Messages")
        
        do{
           
            try listObject = listQuery.findObjects()
        
        }catch _{
            
        }
        
        guard let lists:[PFObject] = listObject else {
            
            return
        }
        
        for list in lists {
            
            guard let objectId = list.objectId else {
                
                 return
            }
            
            guard let createdBy:PFUser = list.objectForKey("CreatedBy") as? PFUser else {
                
               return
            }
            
            guard let recipient:PFUser = list.objectForKey("Recipient") as? PFUser else {
                
                return
            }
            
            guard let message:PFObject = list.objectForKey("Message") as? PFObject else {
                
                return
            }
            
            guard let status:Bool = list.objectForKey("Status") as? Bool else {
                
                return
            }
            
            if createdBy.objectId == currentUser?.objectId || recipient.objectId == currentUser?.objectId {
                
                guard let messageRelation:PFRelation = list.relationForKey("Message") else {
                    
                    return
                }
                
                let messageQuery = messageRelation.query()
                
                do {
                    
                    try messageObject = messageQuery?.findObjects()
                    
                }catch _ {
                    
                }
                
                guard let userMessages = messageObject else {
                    
                    return
                }
                
                for userMessage in userMessages {
                    
                    
                }
            }
            
        }
    }
    
    func sendMessages(){
        
        
    }
}