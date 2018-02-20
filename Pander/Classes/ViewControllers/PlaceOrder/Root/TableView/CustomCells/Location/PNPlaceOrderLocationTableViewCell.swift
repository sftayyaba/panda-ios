//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var tickViewWidthContraint: NSLayoutConstraint!
    
    @IBOutlet weak var addressLabelView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContent(address: PNAddresses){
        self.addressLabelView.text = address.nick != nil ? address.nick : address.street
        
        if address.isSelected{
            setSelected()
        }else{
            setUnSelected()
        }
    }
    
    
    func setCardContent(card:PNCards) {
        self.addressLabelView.text = card.lastFour
    }
    
    
    func setSelected(){
        self.tickViewWidthContraint.constant = 13
    }
    
    func setUnSelected(){
        self.tickViewWidthContraint.constant = 0
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
