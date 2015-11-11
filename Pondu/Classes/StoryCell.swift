//
//  StoryCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    
  
    @IBOutlet weak var Panaorama: UIView!
    
    var motionView:PanoramaView!
    
    override func awakeFromNib() {
         motionView = PanoramaView(frame: self.Panaorama.bounds)
        
        self.Panaorama.addSubview(motionView)
    }
    
    
    
}
