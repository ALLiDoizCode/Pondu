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
}