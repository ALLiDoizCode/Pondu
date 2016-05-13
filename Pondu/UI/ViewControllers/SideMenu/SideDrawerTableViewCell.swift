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
    
    func commonSetup() {
        //self.accessoryCheckmarkColor = UIColor.whiteColor()
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.autoresizingMask = [ .FlexibleHeight, .FlexibleWidth ]
        let backgroundColor = UIColor(red: 122 / 255, green: 126 / 255, blue: 128 / 255, alpha: 1.0)
        backgroundView.backgroundColor = backgroundColor
        
        self.backgroundView = backgroundView
        
        self.textLabel?.backgroundColor = UIColor.clearColor()
        self.textLabel?.textColor = UIColor(red: 230 / 255, green: 236 / 255, blue: 242 / 255, alpha: 1.0)
    }
    
     func updateContentForNewContentSize() {
        self.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

}
