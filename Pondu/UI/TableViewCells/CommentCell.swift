//
//  CommentCell.swift
//  Pondu
//
//  Created by Jonathan Green on 2/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var border: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            
            
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.masksToBounds = true
            
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
