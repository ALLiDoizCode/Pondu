//
//  SideDrawerTableViewCell.swift
//  Pondu
//
//  Created by Jonathan Green on 5/13/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class SideDrawerTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = self.imageView!.frame
        let imageSize = 20 as CGFloat
        frame.size.height = imageSize
        frame.size.width  = imageSize
        frame.origin.y = frame.origin.y + 10
        self.imageView!.frame = frame
        self.imageView!.clipsToBounds = true
    }
    
    func commonSetup() {
        //self.accessoryCheckmarkColor = UIColor.whiteColor()
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.autoresizingMask = [ .FlexibleHeight, .FlexibleWidth ]
        let backgroundColor = UIColor.purpleColor()
        backgroundView.backgroundColor = backgroundColor
        
        self.backgroundView = backgroundView
        
        self.textLabel?.backgroundColor = UIColor.clearColor()
        self.textLabel?.textColor = UIColor.whiteColor()
    }
    
     func updateContentForNewContentSize() {
        self.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

}
