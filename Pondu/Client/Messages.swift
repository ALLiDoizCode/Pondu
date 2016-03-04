//
//  Messages.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import SwiftEventBus

class Messages {
    
    let currentUser = PFUser.currentUser()
    
    static let sharedInstance = Messages()
    
    var messages:[Message]!
    var convo:[MessageList]!
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
            
            messages = []
            
            guard let objectId = list.objectId else {
                
                 return
            }
            
            guard let createdBy:PFUser = list.objectForKey("CreatedBy") as? PFUser else {
                
               return
            }
            
            guard let createdByIcon:PFFile = createdBy.objectForKey("photo") as? PFFile else {
                
                return
            }
            
            guard let recipient:PFUser = list.objectForKey("Recipient") as? PFUser else {
                
                return
            }
            
            guard let recipientIcon:PFFile = recipient.objectForKey("photo") as? PFFile else {
                
                return
            }
            
            guard let message:PFObject = list.objectForKey("Message") as? PFObject else {
                
                return
            }
            
            guard let status:Bool = list.objectForKey("Status") as? Bool else {
                
                return
            }
            
            if createdBy.objectId == currentUser?.objectId || recipient.objectId == currentUser?.objectId {
                
                if createdBy.objectId == currentUser?.objectId {
                    
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
                        
                        guard let sender:PFUser = userMessage.objectForKey("Sender") as? PFUser else {
                            
                            return
                        }
                        
                        guard let userName = sender.username else {
                            
                            return
                        }
                        
                        guard let userIcon:PFFile = sender.objectForKey("photo") as? PFFile else {
                            
                            return
                        }
                        
                        guard let description:String = userMessage.objectForKey("Description") as? String else {
                            
                            return
                        }
                        
                        guard let date = userMessage.createdAt else {
                            
                            return
                        }
                        
                        if let media:PFFile = userMessage.objectForKey("Media") as? PFFile {
                            
                            let senderMessage = Message(theObjectId: userMessage.objectId!, theDescription: description, theMedia: media.url!, theSender: userName, theIcon: userIcon.url!,theDate: date)
                            
                            messages.append(senderMessage)
                            
                        }else {
                            
                            let senderMessage = Message(theObjectId: userMessage.objectId!, theDescription: description, theMedia: "", theSender: userName, theIcon: userIcon.url!,theDate: date)
                            
                            messages.append(senderMessage)
                        }
                    }
                    
                    let theList = MessageList(theIcon: recipientIcon.url, theName: recipient.username!, theTime: (messages.last?.date)!, theStatus: status, theMessages: messages, theCreadtedBy: createdBy.objectId!, theRecipient: recipient.objectId!, theObjectId: objectId)
                    
                    convo.append(theList)
                    
                }else if recipient.objectId == currentUser?.objectId {
                    
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
                        
                        guard let sender:PFUser = userMessage.objectForKey("Sender") as? PFUser else {
                            
                            return
                        }
                        
                        guard let userName = sender.username else {
                            
                            return
                        }
                        
                        guard let userIcon:PFFile = sender.objectForKey("photo") as? PFFile else {
                            
                            return
                        }
                        
                        guard let description:String = userMessage.objectForKey("Description") as? String else {
                            
                            return
                        }
                        
                        guard let date = userMessage.createdAt else {
                            
                            return
                        }
                        
                        if let media:PFFile = userMessage.objectForKey("Media") as? PFFile {
                            
                            let senderMessage = Message(theObjectId: userMessage.objectId!, theDescription: description, theMedia: media.url!, theSender: userName, theIcon: userIcon.url!,theDate: date)
                            
                            messages.append(senderMessage)
                            
                        }else {
                            
                            let senderMessage = Message(theObjectId: userMessage.objectId!, theDescription: description, theMedia: "", theSender: userName, theIcon: userIcon.url!,theDate: date)
                            
                            messages.append(senderMessage)
                        }
                    }
                    
                    let theList = MessageList(theIcon: createdByIcon.url, theName: recipient.username!, theTime: (messages.last?.date)!, theStatus: status, theMessages: messages, theCreadtedBy: createdBy.objectId!, theRecipient: recipient.objectId!, theObjectId: objectId)
                    
                    convo.append(theList)
                }
            }
            
        }
        
        SwiftEventBus.post("Messages")
    }
    
    func sendMessages(){
        
        
    }
}