//
//  StoryCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
  
    @IBOutlet weak var Panaorama: UIView!
    var motionView:PanoramaView!
   
    
    override func awakeFromNib() {
        
        
        
        motionView = PanoramaView(frame: Panaorama.bounds)
        motionView.setImage(UIImage(named: "bob")!)
        motionView.setScrollIndicatorEnabled(false)
        Panaorama.addSubview(self.motionView)
        userIcon.layer.cornerRadius = userIcon.frame.height/2
        userIcon.layer.borderColor = UIColor.whiteColor().CGColor
        userIcon.layer.borderWidth = 1.5
        userIcon.layer.masksToBounds = true
        userIcon.clipsToBounds = true
        
        print("native height \(UIScreen.mainScreen().nativeBounds.height)")
        
        
        
      
        
        if UIScreen.mainScreen().bounds.height == 1136  {
            
           
        }
        
        
    }
    
    /*override func layoutSubviews() {
        super.layoutSubviews()
        userIcon.frame = CGRectMake(10, 400, userIcon.frame.size.width, userIcon.frame.size.height)
    }*/
    
    /*switch UIScreen.mainScreen().nativeBounds.height {
    case 480:
    print("iPhone Classic")
    case 960:
    print("iPhone 4 or 4S")
    case 1136:
   
    
    print("iPhone 5 or 5S or 5C")
    case 1334:
    print("iPhone 6 or 6S")
    case 2208:
    print("iPhone 6+ or 6S+")
    default:
    print("unknown")
    }*/
    
}
