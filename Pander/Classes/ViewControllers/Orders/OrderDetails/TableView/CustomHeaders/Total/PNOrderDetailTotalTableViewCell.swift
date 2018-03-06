//
//  PNOrderDetailTotalTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailTotalTableViewCell: UITableViewCell {

    public var editAndReorderButtonCallback : (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAndReorderAction(_ sender: Any) {
        if let callBack = editAndReorderButtonCallback{
            callBack()
        }
    }
}
