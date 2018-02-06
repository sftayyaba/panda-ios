//
//  PNPartySizeTableViewCell.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import UIKit

class PNDeliveryDateTableViewCell: UITableViewCell {

    @IBOutlet var seletedStateImageView: UIImageView!
    @IBOutlet var selectedStateConstratints: NSLayoutConstraint!
    @IBOutlet var dateTitle: UILabel!

    var title: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
    }
    
    func setContent(status:Bool,title: String) {
        self.dateTitle.text = title
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
        self.dateTitle.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
    
    fileprivate func unselectedState() {
        self.selectedStateConstratints.constant = 0
        self.seletedStateImageView.isHidden = true
        self.dateTitle.font = UIFont.regularApplicationFontOfSize(size: 14)
    }
}
