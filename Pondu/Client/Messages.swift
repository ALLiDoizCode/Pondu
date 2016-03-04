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
    var convo:[MessageList] = []
    var listObject:[PFObject]!
    var messageObject:[PFObject]!
    var theSender:PFUser!
    var theCreatedBy:PFUser!
    var theRecipient:PFUser!
    
    func getMessages(){
        
        print("convo")
        
        let listQuery = PFQuery(className: "Messages")
        
        do{
           
            try listObject = listQuery.findObjects()
        
        }catch _{
            
        }
        
        guard let lists:[PFObject] = listObject else {
            
            return
        }
        
        for list in lists {
            
            print("convo")
            messages = []
            
            guard let objectId = list.objectId else {
                
                 return
            }
            
            print(objectId)
            
            guard let createdBy:PFUser = list.objectForKey("CreatedBy") as? PFUser else {
                
               return
            }
            
            do {
                
                try theCreatedBy = createdBy.fetch()
                
            }catch _{
                
            }
            
            guard let createdByIcon:PFFile = theCreatedBy.objectForKey("photo") as? PFFile else {
                
                return
            }
            
            print(createdByIcon.url)
            
            
            guard let recipient:PFUser = list.objectForKey("Recipient") as? PFUser else {
                
                return
            }
            
            do {
                
                try theRecipient = recipient.fetch()
                
            }catch _{
                
            }
            
            
            guard let recipientIcon:PFFile = theRecipient.objectForKey("photo") as? PFFile else {
                
                return
            }
            
            
            
            guard let status:Bool = list.objectForKey("Status") as? Bool else {
                
                return
            }
            
            print("creator ",theCreatedBy.objectId)
            print("current ", currentUser?.objectId)
            
            if theCreatedBy.objectId == currentUser?.objectId {
                
                print("I am creator")
                
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
                    
                    do {
                        
                        try theSender = sender.fetch()
                        
                    }catch _{
                        
                    }
                    
                    guard let userName = theSender.username else {
                        
                        return
                    }
                    
                    guard let userIcon:PFFile = theSender.objectForKey("photo") as? PFFile else {
                        
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
                
                let theList = MessageList(theIcon: recipientIcon.url, theName: theRecipient.username!, theTime: list.createdAt!, theStatus: status, theMessages: messages, theCreadtedBy: theCreatedBy.objectId!, theRecipient: theRecipient.objectId!, theObjectId: objectId)
                
                convo.append(theList)
                
                
                
            }else if theRecipient.objectId == currentUser?.objectId {
                
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
                    
                    do {
                        
                        try theSender = sender.fetch()
                        
                    }catch _{
                        
                    }
                    
                    guard let userName = sender.username else {
                        
                        return
                    }
                    
                    guard let userIcon:PFFile = theSender.objectForKey("photo") as? PFFile else {
                        
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
                
                let theList = MessageList(theIcon: createdByIcon.url, theName: theRecipient.username!, theTime: list.createdAt!, theStatus: status, theMessages: messages, theCreadtedBy: theCreatedBy.objectId!, theRecipient: theRecipient.objectId!, theObjectId: objectId)
                
                convo.append(theList)
                
            }
            
        }
        
        //print("posting \(convo.count) messages")
        
        SwiftEventBus.post("Messages", sender: convo)
    }
    
    func sendMessages(){
        
        
    }
}