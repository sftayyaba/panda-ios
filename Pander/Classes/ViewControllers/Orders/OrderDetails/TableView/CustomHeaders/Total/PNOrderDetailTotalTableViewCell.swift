//
//  PNOrderDetailTotalTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailTotalTableViewCell: UITableViewCell {

    public var editAndReorderButtonCallback : (() -> Void)?
    
    @IBOutlet var editAndReorderBtn: UIButton!
    @IBOutlet var reorderBtn: UIButton!
    
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
    
    
    func setContent(cuisine:String) {
        if cuisine == "0" {
            self.editAndReorderBtn.setTitle("Contact Restaurant", for: .normal)
            self.reorderBtn.setTitle("Edit & Reorder", for: .normal)
        }else {
            self.editAndReorderBtn.setTitle("Edit & Reorder", for: .normal)
            self.reorderBtn.setTitle("Re-Order", for: .normal)
        }
    }
}
