//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit
import MGSwipeTableCell

class PNCurrentLocationTableViewCell: MGSwipeTableCell {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
        
        self.rightButtons = [
            MGSwipeButton(title: "Set as default", backgroundColor: UIColor.customRedColor()),
            MGSwipeButton(title: "Edit",backgroundColor: UIColor.customRedColor()),
            MGSwipeButton(title: "Remove",backgroundColor: UIColor.customRedColor())
            ].reversed()
        
        
        self.rightButtons = self.rightButtons.map { (view) -> UIView in
            if let button = view as? MGSwipeButton{
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            }
            return view
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    func setContent(address: PNAddresses ) {
        self.cellContentWith(state: address.isSelected)
        
        if let nick = address.nick{
            self.locationLabel.text = nick
            
        }else if let streetAddress = address.street{
            self.locationLabel.text = streetAddress
        }
        
    }
    
    func cellContentWith(state: Bool) {
        if state {
            self.selectedState()
        }else {
            self.unselectedState()
        }
    }
    
    fileprivate func selectedState() {
        self.selectedStateConstratints.constant = 35
        self.seletedStateImageView.isHidden = false
    }
    
    fileprivate func unselectedState() {
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
}
