//
//  AddComment.swift
//  Pondu
//
//  Created by Jonathan Green on 2/18/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation

class AddComment {
    
    let makeComment = comments()
    
    func comment(objectId:String,description:String){
        
        makeComment.addComment(objectId, description: description)
        
    }
}