//
//  PNHomeFeaturedItemsCollectionReusableView.swift
//  Pander
//
//  Created by Shery on 01/02/2018.
//

import UIKit

class PNHomeFeaturedCuisineCollectionReusableView: UICollectionReusableView {

    
    @IBOutlet var selectedButton: UIButton!
    @IBOutlet var arrowImage: UIImageView!
    @IBOutlet var seeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!

    public var didMoveDownButtonCallback : (() -> Void)?
    public var didMoveUpButtonCallback : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(title: String) {
        self.titleLabel.text = title
    }
    
    @IBAction func selectionButtonTapped(_ sender: Any) {
        if selectedButton.isSelected {
            
            if let callBack = self.didMoveUpButtonCallback {
                callBack()
            }
            
            self.seeLabel.text = "See more"
            self.arrowImage.image = UIImage(named: "Arrow - Big - down - Black")
            self.selectedButton.isSelected = false
        }else {
         
            if let callBack = self.didMoveDownButtonCallback {
                callBack()
            }
         self.seeLabel.text = "See less"
         self.arrowImage.image = UIImage(named: "Arrow - Big - Up - Black")
         self.selectedButton.isSelected = true
        }
    }
}
