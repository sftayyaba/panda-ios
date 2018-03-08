//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderTotalTableViewCell: UITableViewCell {

    
    public var editAndReorderButtonCallback : (() -> Void)?
    public var newSuggestionButtonCallback : (() -> Void)?
    
    @IBOutlet var totalPriceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func getNewSuggestionTapped(_ sender: Any) {
        if let callBack = newSuggestionButtonCallback{
            callBack()
        }
    }
    
    
    @IBAction func reORdertapped(_ sender: Any) {
        if let callBack = editAndReorderButtonCallback{
            callBack()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
