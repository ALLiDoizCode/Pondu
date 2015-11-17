//
//  StoryIconVIew.swift
//  Pondu
//
//  Created by Jonathan Green on 11/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class StoryIconVIew: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subImage.layer.cornerRadius = subImage.layer.frame.height/2
        self.subImage.layer.borderWidth = 1.5
        self.subImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.subImage.layer.masksToBounds = true
    }

}
