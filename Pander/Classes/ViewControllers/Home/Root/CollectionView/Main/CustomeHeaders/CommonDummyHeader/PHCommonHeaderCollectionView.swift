//
//  PHHomeCollectionReusableView.swift
//  Pander
//
//  Created by Shery on 31/01/2018.
//

import UIKit

class PHCommonHeaderCollectionView: UICollectionReusableView {

    @IBOutlet var arrowUpButton: UIButton!
    @IBOutlet var searchView: UIView!
    @IBOutlet var sepratorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.arrowUpButton.isHidden = true
    }
}
