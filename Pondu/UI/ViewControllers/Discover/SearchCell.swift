//
//  SearchCell.swift
//  Pondu
//
//  Created by Jonathan Green on 12/23/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
       
    }

 
    @IBAction func addBtn(sender: AnyObject) {
    }
    
    @IBAction func messageBtn(sender: AnyObject) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.icon.layer.cornerRadius = self.icon.frame.height/2
        self.icon.layer.masksToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
