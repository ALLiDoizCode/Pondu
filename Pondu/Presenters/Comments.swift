//
//  Comments.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class userComments {
    
    let thiscomment = comments()
    
    func makeComment(postID:String){
        
        thiscomment.userComment(postID)
    }
}
