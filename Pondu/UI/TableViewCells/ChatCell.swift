//
//  ChatCell.swift
//  Pondu
//
//  Created by Jonathan Green on 3/4/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        message.text = "Response about ones option of the party or event in discussion. maybe it was good  maybe it was bad either way.Response about ones option of the party or event in discussion. maybe it was good  maybe it was bad either way."
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
