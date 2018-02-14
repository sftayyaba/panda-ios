//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderPaymentTableViewCell: UITableViewCell {

    var dish: PNOrderDish!
    @IBOutlet weak var redPriceLabel: UILabel!
    @IBOutlet weak var greyPriceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var detailLabelMaxHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setContent(dish: PNOrderDish){
        self.dish = dish
        if let price = dish.price{
            self.redPriceLabel.text = price.format(f: "")
        }
        self.itemTitleLabel.text = dish.name
        self.detailLabel.text = dish.descriptionValue
        
        if dish.isSelected{
            self.detailLabelMaxHeightConstraint.constant = 200
        }else{
            self.detailLabelMaxHeightConstraint.constant = 0
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        dish.isSelected = selected
//        if dish.isSelected{
//            self.detailLabelMaxHeightConstraint.constant = 200
//        }else{
//            self.detailLabelMaxHeightConstraint.constant = 0
//        }
        // Configure the view for the selected state
    }
    
}
