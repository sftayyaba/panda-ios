//
//  PNHomeSeeLessCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNHomeSeeLessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemDetailLabel.layer.shadowOpacity = 1.0;
        itemDetailLabel.layer.shadowRadius = 0.0;
        itemDetailLabel.layer.shadowColor = UIColor.black.cgColor;
        //[UIColor, blackColor].CGColor;
        itemDetailLabel.layer.shadowOffset = CGSize(width:0.0, height: -1.0);
        //CGSizeMake(0.0, -1.0);

    }

}
