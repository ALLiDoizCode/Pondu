//
//  LiveCommentCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/28/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class LiveCommentCell: UITableViewCell {

    @IBOutlet weak var tiniView: UIView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        tiniView.layer.cornerRadius = 2
        tiniView.layer.masksToBounds = true
        
        self.contentView.backgroundColor = UIColor.clearColor()
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.layer.borderWidth = 1.5
        avatar.layer.borderColor = UIColor.whiteColor().CGColor
        avatar.clipsToBounds = true
        avatar.layer.masksToBounds = true
    }

}
