//
//  MessagesCell.swift
//  Pondu
//
//  Created by Jonathan Green on 1/29/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.icon.layer.cornerRadius = self.icon.frame.height/2
            self.icon.layer.masksToBounds = true
            
            
        });
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
