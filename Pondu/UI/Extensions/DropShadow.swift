//
//  DropShadow.swift
//  Pondu
//
//  Created by Jonathan Green on 3/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit


class DropShadow {
    
    func shadow(view:UIView,color:UIColor) {
        
        view.layer.shadowColor = color.CGColor
        view.layer.shadowOffset = CGSizeMake(0,2.5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1
        
    }
}