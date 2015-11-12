//
//  StoryLayout.swift
//  Pondu
//
//  Created by Jonathan Green on 11/12/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class StoryLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionViewSize: CGSize = self.collectionView!.bounds.size
        let rectBounds: CGRect = self.collectionView!.bounds
        let halfWidth: CGFloat = rectBounds.size.width * CGFloat(0.50)
        let proposedContentOffsetCenterX: CGFloat = proposedContentOffset.x + halfWidth
        
        let proposedRect: CGRect = self.collectionView!.bounds
        
        let attributesArray:NSArray = self.layoutAttributesForElementsInRect(proposedRect)!
        
        var candidateAttributes:UICollectionViewLayoutAttributes?
        
        
        for layoutAttributes : AnyObject in attributesArray {
            
            if let _layoutAttributes = layoutAttributes as? UICollectionViewLayoutAttributes {
                
                if _layoutAttributes.representedElementCategory != UICollectionElementCategory.Cell {
                    continue
                }
                
                if candidateAttributes == nil {
                    candidateAttributes = _layoutAttributes
                    continue
                }
                
                if fabsf(Float(_layoutAttributes.center.x) - Float(proposedContentOffsetCenterX)) < fabsf(Float(candidateAttributes!.center.x) - Float(proposedContentOffsetCenterX)) {
                    candidateAttributes = _layoutAttributes
                }
                
            }
        }
        
        if attributesArray.count == 0 {
            return CGPoint(x: proposedContentOffset.x - halfWidth * 2,y: proposedContentOffset.y)
        }
        
        return CGPoint(x: candidateAttributes!.center.x - halfWidth, y: proposedContentOffset.y)
    }
    
    
}
