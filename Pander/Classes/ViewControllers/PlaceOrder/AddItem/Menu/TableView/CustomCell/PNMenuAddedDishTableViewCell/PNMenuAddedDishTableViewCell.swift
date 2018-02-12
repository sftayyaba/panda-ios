//
//  PNMenuAddedDishTableViewCell.swift
//  Pander
//
//  Created by Abdul Sami on 12/02/2018.
//

import UIKit

class PNMenuAddedDishTableViewCell: UITableViewCell {

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

        // Configure the view for the selected state
    }
    
}
