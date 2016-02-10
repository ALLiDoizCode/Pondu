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
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var PostName: UILabel!
    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var live: SpringLabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
       
        
        // These are the two convenience height constants
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        
        // Calculate the delta of the cell as it’s moving to figure out how much to adjust the alpha in the following step.
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        // Based on the range constants, update the cell’s alpha based on the delta value.
        let minAlpha: CGFloat = 0.47
        let maxAlpha: CGFloat = 0.75
        coverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        descriptionHead.transform = CGAffineTransformMakeScale(scale, scale)
        post.transform = CGAffineTransformMakeScale(scale, scale)
        comments.transform = CGAffineTransformMakeScale(scale, scale)
        likes.transform = CGAffineTransformMakeScale(scale, scale)
        iconView.transform = CGAffineTransformMakeScale(scale, scale)
        live.transform = CGAffineTransformMakeScale(scale, scale)
        //time.transform = CGAffineTransformMakeScale(scale, scale)
        //visualEffectView.transform = CGAffineTransformMakeScale(scale, scale)
        
        descriptionHead.alpha = delta
        post.alpha = delta
        comments.alpha = delta
        likes.alpha = delta
        //time.alpha = delta
        
        
        if delta > 0.1 {
            
            eventTitle.hidden = true
            
            
        }else{
            
            eventTitle.hidden = false
            
        }
        
        eventTitle.alpha = 1 - delta

        
        
        //visualEffectView.frame = bgImage.frame
        //visualEffectView.clipsToBounds = true
        //bgImage.addSubview(visualEffectView)
        
                
    }
    
    
    
    override func awakeFromNib() {
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.masksToBounds = true
       
        
        
        
       
        
    }
}


