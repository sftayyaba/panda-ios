//
//  PNGuestLetGetStartedStepTwoCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 09/01/2018.
//

import Foundation
import UIKit
class PNPartySizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagNameMaxWidthConstraint:NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.titleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 13
        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
        
    }
}
