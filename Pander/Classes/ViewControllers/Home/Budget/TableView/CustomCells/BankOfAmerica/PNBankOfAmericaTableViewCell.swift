//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit
import MGSwipeTableCell
class PNBankOfAmericaTableViewCell: MGSwipeTableCell {

    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
  
    @IBOutlet var cardType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
        
        self.rightButtons = [
            MGSwipeButton(title: "Set as default", backgroundColor: UIColor.customRedColor()),
            MGSwipeButton(title: "Edit", backgroundColor: UIColor.customRedColor()),
            MGSwipeButton(title: "Remove",backgroundColor: UIColor.customRedColor())
            ].reversed()
        
        
        self.rightButtons = self.rightButtons.map { (view) -> UIView in
            if let button = view as? MGSwipeButton{
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            }
            return view
        }
    }
    
    func setContent(card:PNCards) {
        
        self.cardType.text = card.nick != nil ? card.nick : card.type! + card.lastFour!
        
        if card.isSelected {
            self.selectedState()
        }else {
            self.unselectedState()
        }
    }
    
    

    
    fileprivate func selectedState() {
        self.selectedStateConstratints.constant = 35
        self.seletedStateImageView.isHidden = false
    }

    fileprivate func unselectedState() {
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
}
