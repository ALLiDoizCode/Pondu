//
//  FavStoryCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/15/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class FavStoryCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var Panaorama: UIView!
    
    //var motionView:PanoramaView!
    
    override func awakeFromNib() {
        
        //motionView = PanoramaView(frame: Panaorama.bounds)
        userIcon.layer.cornerRadius = userIcon.frame.height/2
        userIcon.layer.borderColor = UIColor.whiteColor().CGColor
        userIcon.layer.borderWidth = 1.5
        userIcon.layer.masksToBounds = true
        userIcon.clipsToBounds = true
        
        Panaorama.layer.borderWidth = 3
        Panaorama.layer.borderColor = UIColor.whiteColor().CGColor
        
        
    }
}
