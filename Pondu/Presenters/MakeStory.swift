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
    
    let story = CreateStory()
    
    func addStory(media:NSData){
        
        story.theStory(media)
        
        SwiftEventBus.post("MakeStory")
    }
}