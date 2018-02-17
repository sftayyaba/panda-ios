//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit

class PNMomLocationTableViewCell: UITableViewCell {

    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
    func setContent(status:Bool) {
        self.cellContentWith(state: status)
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
