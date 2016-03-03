//
//  MainCell.swift
//  Pondu
//
//  Created by Jonathan Green on 11/4/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Spring

class MainCell: UICollectionViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var descriptionHead: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var PostName: UILabel!
    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var live: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    
    override func awakeFromNib() {
        
       
        
    }
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
            self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
            self.profileImage.layer.borderWidth = 1.5
            self.profileImage.layer.masksToBounds = true
            self.live.layer.cornerRadius = self.live.frame.size.height/2
            self.live.layer.borderColor = UIColor.grayColor().CGColor
            self.live.layer.borderWidth = 1.5
            self.live.layer.masksToBounds = true
            self.layoutSubviews()
            
            
        }
        
        // These are the two convenience height constants
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        
        // Calculate the delta of the cell as it’s moving to figure out how much to adjust the alpha in the following step.
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        // Based on the range constants, update the cell’s alpha based on the delta value.
        let minAlpha: CGFloat = 0.47
        let maxAlpha: CGFloat = 0.75
    
        
        let scale = max(delta, 0.5)
        descriptionHead.transform = CGAffineTransformMakeScale(scale, scale)
        post.transform = CGAffineTransformMakeScale(scale, scale)
        comments.transform = CGAffineTransformMakeScale(scale, scale)
        likes.transform = CGAffineTransformMakeScale(scale, scale)
        iconView.transform = CGAffineTransformMakeScale(scale, scale)
        live.transform = CGAffineTransformMakeScale(scale, scale)
        
        descriptionHead.alpha = delta
        live.alpha = delta
        post.alpha = delta
        comments.alpha = delta
        likes.alpha = delta
        
        if delta > 0.1 {
            
            eventTitle.hidden = true
            
            
        }else{
            
            eventTitle.hidden = false
            
        }
        
        eventTitle.alpha = 1 - delta
                
    }
}


