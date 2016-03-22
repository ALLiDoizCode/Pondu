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
    
    func makeRoom(creator:String,recipient:String,completion:(data:String) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "RoomMade") { result in
            
            guard let roomData:String = result.object as? String else {
                
                return
            }
            completion(data: roomData)
            
            SwiftEventBus.unregister("RoomMade")
        }
        
    }
    
    func getMessages(completion:(data:[MessageList]) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "Messages") { result in
            
            guard let messageData:[MessageList] = result.object as? [MessageList] else {
                
                return
            }
            
            print("presenting \(messageData.count) messages")
            
            completion(data: messageData)
            SwiftEventBus.unregister("Messages")
        }
        
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
    
    func sendMessage(objectId:String,text:String,hasImage:Bool,image:UIImage?){
        
        SwiftEventBus.onBackgroundThread(self, name: "SentMsg") { result in
            
            print("fire sent presenter")
            
            SwiftEventBus.postToMainThread("updateMsg")
            
            SwiftEventBus.unregister(self, name: "SentMsg")
        }
        
    }
}