//
//  MakeStory.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class MakeStory {
    
    func addStory(media:NSData){
        
        SwiftEventBus.post("MakeStory")
    }
}