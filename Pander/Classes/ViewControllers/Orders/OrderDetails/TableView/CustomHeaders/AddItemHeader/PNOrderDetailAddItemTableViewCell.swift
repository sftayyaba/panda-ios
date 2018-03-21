//
//  PNOrderDetailAddItemTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 3/7/18.
//

import UIKit

class PNOrderDetailAddItemTableViewCell: UITableViewCell {

    public var didAddItemButtonCallback : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addNewItemPressed(_ sender: UIButton) {
        if let callBack = didAddItemButtonCallback{
            callBack()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
