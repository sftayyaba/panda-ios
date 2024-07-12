//
//  PNHomeMainSeeMoreCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNHomeMainSeeMoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemLabel.layer.shadowOpacity = 1.0;
        itemLabel.layer.shadowRadius = 0.0;
        itemLabel.layer.shadowColor = UIColor.black.cgColor;
        //[UIColor, blackColor].CGColor;
        itemLabel.layer.shadowOffset = CGSize(width:0.0, height: -1.0);//CGSizeMake(0.0, -1.0);
    }

}
