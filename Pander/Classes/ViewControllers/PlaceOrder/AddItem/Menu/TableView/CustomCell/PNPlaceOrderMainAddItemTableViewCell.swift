//
//  PNPlaceOrderMainAddItemTableViewCell.swift
//  Pander
//
//  Created by Shery on 06/02/2018.
//

import UIKit

class PNPlaceOrderMainAddItemTableViewCell: UITableViewCell {

    var dish: PNOrderDish!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContent(dish: PNOrderDish){
        
        self.itemTitleLabel.text = dish.name
        if let price = dish.price{
            self.priceLabel.text = "\(price)"
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
}
