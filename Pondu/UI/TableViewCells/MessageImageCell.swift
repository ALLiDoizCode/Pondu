//
//  MessageImageCell.swift
//  Pondu
//
//  Created by Jonathan Green on 3/8/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class MessageImageCell: UITableViewCell {

    @IBOutlet weak var sentImage: UIImageView!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var bar: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
