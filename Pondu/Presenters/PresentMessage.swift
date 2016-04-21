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
    
    let client = Messages()
    
    func makeRoom(creator:String,recipient:String,completion:(data:String) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "RoomMade") { result in
            
            guard let roomData:String = result.object as? String else {
                
                return
            }
            completion(data: roomData)
            
            SwiftEventBus.unregister("RoomMade")
        }
        
    }
    
    func getMessages(userName:String,completion:(data:[Message]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "Messages") { result in
            
            guard let messageData:[Message] = result.object as? [Message] else {
                
                return
            }
            
            print("presenting \(messageData.count) messages")
            
            completion(data: messageData)
            SwiftEventBus.unregister("Messages")
        }
        
        client.getMessage(userName)
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
        
    }
    
    func sendMessage(message:Message,recipent:String){
        
        print("Sending message to \(recipent)")
        
        client.sendMessage(message,recipent:recipent)
        
    }
    
    func sendMessageWithImage(message:Message,image:UIImage,recipent:String){
        
        print("Sending message with image")
        
        
        client.sendMessage(message,recipent:recipent)
        
    }
}