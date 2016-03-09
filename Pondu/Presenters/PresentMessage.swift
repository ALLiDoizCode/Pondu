//
//  PresentMessage.swift
//  Pondu
//
//  Created by Jonathan Green on 3/4/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class PresentMessage {
    
    let client = Messages.sharedInstance
    
    func getMessages(completion:(data:[MessageList]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "Messages") { result in
            
            guard let messageData:[MessageList] = result.object as? [MessageList] else {
                
                return
            }
            
            print("presenting \(messageData.count) messages")
            
            completion(data: messageData)
            SwiftEventBus.unregister("Messages")
        }
        
        client.getMessages()
    }
    
    func messageWithId(objectId:String,completion:(data:[Message]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "MsgWithId") { result in
            
            guard let messageData:[Message] = result.object as? [Message] else {
                
                return
            }
            
            print("presenting \(messageData.count) messages")
            
            completion(data: messageData)
            SwiftEventBus.unregister("MsgWithId")
        }
        
        client.getMessageWithId(objectId)
    }
    
    func sendMessage(objectId:String,text:String,hasImage:Bool,image:UIImage?,completion:() -> Void){
        
        SwiftEventBus.onMainThread(self, name: "SentMessage") { result in
            
            completion()
            SwiftEventBus.unregister("SentMessage")
        }
        
        client.sendMessages(objectId, text: text,hasImage: hasImage,image:image)
    }
}