//
//  SearchCell.swift
//  Pondu
//
//  Created by Jonathan Green on 12/23/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    let presenter = theUser()

    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var userName:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.icon.layer.cornerRadius = self.icon.frame.height/2
            self.icon.layer.masksToBounds = true
            
            
        });
        
        
    }
    
    @IBAction func follow(sender: AnyObject) {
        
        presenter.addUser(userName) { (success) -> Void in
            
            if success == true {
                
                print("users added")
                
                
                self.add.setBackgroundImage(UIImage(named: "Checkmark"), forState: .Normal)
                
            }else {
                
                print("the user was not added")
            }
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
