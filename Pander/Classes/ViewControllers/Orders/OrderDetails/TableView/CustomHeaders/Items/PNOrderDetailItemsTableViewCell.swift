//
//  PNOrderDetailItemsTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishDiscountedPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
