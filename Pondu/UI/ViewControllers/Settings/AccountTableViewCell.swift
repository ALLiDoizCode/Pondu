//
//  AccountTableViewCell.swift
//  Pondu
//
//  Created by Jonathan Green on 5/24/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material

class AccountTableViewCell: MaterialTableViewCell {
    
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
        backgroundView.backgroundColor = MaterialColor.white
        
        self.backgroundView = backgroundView
        
        self.textLabel?.backgroundColor = UIColor.clearColor()
        self.textLabel?.textColor = MaterialColor.grey.darken2
    }
    
    func updateContentForNewContentSize() {
        self.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
