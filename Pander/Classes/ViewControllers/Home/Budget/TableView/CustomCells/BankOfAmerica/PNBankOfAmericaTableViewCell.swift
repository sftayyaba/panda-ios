//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit

class PNBankOfAmericaTableViewCell: UITableViewCell {

    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
  
    @IBOutlet var cardType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
    
    func setContent(card:PNCards) {
        
        self.cardType.text = card.nick != nil ? card.nick : card.type! + card.lastFour!
        
        if card.isSelected {
            self.selectedState()
        }else {
            self.unselectedState()
        }
    }
    
    
//    func cellContentWith(state: Bool) {
//        if state {
//            self.selectedState()
//        }else {
//            self.unselectedState()
//        }
//    }
    
    fileprivate func selectedState() {
        self.selectedStateConstratints.constant = 35
        self.seletedStateImageView.isHidden = false
    }

    fileprivate func unselectedState() {
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
}
