//
//  MainStoryCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/16/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class MainStoryCell: UICollectionViewCell {
    
  
    @IBOutlet weak var icon: UIImageView!
  
    override func layoutSubviews() {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.icon.layer.cornerRadius = self.icon.layer.frame.height/2
            self.icon.layer.borderColor = UIColor.whiteColor().CGColor
            self.icon.layer.borderWidth = 2
            self.icon.layer.masksToBounds = true

            
        });
        
    }
}
