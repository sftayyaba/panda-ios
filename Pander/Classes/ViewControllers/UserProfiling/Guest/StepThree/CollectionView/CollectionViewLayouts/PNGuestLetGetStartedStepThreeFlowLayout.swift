//
//  FlowLayout.swift
//  Pander
//
//  Created by Shery on 11/01/2018.
//

import Foundation
import UIKit

class PNGuestLetGetStartedStepThreeFlowLayout: UICollectionViewFlowLayout {
    
      func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [AnyObject]()
        // use a value to keep track of left margin
        var leftMargin: CGFloat = 0.0;
        
        for attributes in attributesForElementsInRect! {
            let refAttributes = attributes
            // assign value if next row
            if (refAttributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += refAttributes.frame.size.width + 8
            newAttributesForElementsInRect.append(refAttributes)
        }
        return newAttributesForElementsInRect
    }
}
