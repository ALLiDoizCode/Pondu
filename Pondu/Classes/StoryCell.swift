//
//  StoryCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userIcon: UIImageView!
  
    @IBOutlet weak var Panaorama: UIView!
    
   
    
    override func awakeFromNib() {
        
        
        userIcon.layer.cornerRadius = userIcon.frame.height/2
        userIcon.layer.borderColor = UIColor.whiteColor().CGColor
        userIcon.layer.borderWidth = 1.5
        userIcon.layer.masksToBounds = true
        userIcon.clipsToBounds = true
    }
    
    
    
}
