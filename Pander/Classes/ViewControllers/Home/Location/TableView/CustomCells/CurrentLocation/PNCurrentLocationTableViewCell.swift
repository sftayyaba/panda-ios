//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit

class PNCurrentLocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
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
