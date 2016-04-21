//
//  Messages.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class Messages {
    
    let user = UserClient()
    
    let storeMessage = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Message",
        KCSStoreKeyCollectionTemplateClass : Message.self
        ])
    
    let storeMessageThread = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "MessageThread",
        KCSStoreKeyCollectionTemplateClass : Thread.self
        ])
    
    func sendMessage(message:Message,recipent:String){
        
        let myUserName = user.currentUser().username
        
        print("client sending message")
        
        print("client setup query")
        
        print("client checking for exsting thread")
        
        getThread(myUserName, user2: recipent) { (thread) in
            
            if thread != nil {
                
                print("found thread")
                
                message.sender = myUserName
                //message.thread = thread
                message.threadId = thread.entityId
                
                self.storeMessage.saveObject(
                    message,
                    withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                        if errorOrNil != nil {
                            //save failed
                            NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                        } else {
                            //save was successful
                            NSLog("Successfully saved message thread (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                            
                            //SwiftEventBus.post("makeWall", sender: true)
                        }
                    },
                    withProgressBlock: nil
                )
            }else {
                
                print("thread is nil")
                
                
                message.sender = myUserName
                message.thread = Thread(firstUser: myUserName, secondUser: recipent)
                
                message.threadId = message.thread!.entityId
                
                self.storeMessage.saveObject(
                    message,
                    withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                        if errorOrNil != nil {
                            //save failed
                            NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                        } else {
                            //save was successful
                            NSLog("Successfully saved message thread (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                            
                            //SwiftEventBus.post("makeWall", sender: true)
                        }
                    },
                    withProgressBlock: nil
                )
            }
        }
        
    }
    
    func getMessage(userName:String) {
        
        var messages:[Message] = []
        
        let myUserName = user.currentUser().username
        
        getThread(myUserName, user2: userName) { (thread) in
            
            let query = KCSQuery(onField: "threadId", withExactMatchForValue: thread.entityId)
            
            self.storeMessage.queryWithQuery(query, withCompletionBlock: { (objects, error) in
                
                if let objects = objects {
                    
                    messages = objects as! [Message]
                    SwiftEventBus.post("Messages", sender: messages)
                }
                
            }, withProgressBlock: nil)
        }
    }
    
    func getThread(user1:String,user2:String,completion:(thread:Thread!) -> Void) {
        
        var thread:Thread!
        
        let query = KCSQuery(onField: "user1", usingConditional: .KCSOr, forValue: [user1,user2])
        let query2 = KCSQuery(onField: "user2", usingConditional: .KCSOr, forValue: [user1,user2])
        let joinQuery = query.queryByJoiningQuery(query2, usingOperator: .KCSAnd)
        
        storeMessageThread.queryWithQuery(joinQuery, withCompletionBlock: { (objects, error) in
            
            if error == nil {
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        thread = object as! Thread
                        
                        print("the threadId is \(thread.entityId)")
                    }
                    
                    completion(thread: thread)
                }
                
                
            }else {
                
                print("Get Thread: the error is \(error.description)")
            }
            
            }, withProgressBlock: nil)
        
        
    }
    
}