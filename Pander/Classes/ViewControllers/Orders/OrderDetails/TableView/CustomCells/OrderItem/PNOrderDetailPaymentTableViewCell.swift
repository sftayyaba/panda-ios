//
//  PNOrderDetailPaymentTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailPaymentTableViewCell: UITableViewCell {

    
    public var didAddItemButtonCallback : (() -> Void)?
    var dish: PNOrderDish!
    @IBOutlet weak var redPriceLabel: UILabel!
    @IBOutlet weak var greyPriceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var detailLabelMaxHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var viewMaxHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var counterLbl: UILabel!
    @IBOutlet var minusBtn: UIButton!
    @IBOutlet var chagneBtn: UIButton!
    @IBOutlet var refreshBtn: UIButton!
    
    var counter = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContent(dish: PNOrderDish){
        self.dish = dish
        if let price = dish.price{
            self.redPriceLabel.text = "$"+price.format(f: "")
        }
        self.itemTitleLabel.text = dish.name
        self.detailLabel.text = dish.descriptionValue
        
        
        if dish.isSelected{
            if dish.descriptionValue != "" {
                self.detailLabelMaxHeightConstraint.constant = 200
                self.viewMaxHeightConstraint.constant = 40
                plusBtn.isHidden = false
                minusBtn.isHidden = false
                counterLbl.isHidden = false
                chagneBtn.isHidden = false
                refreshBtn.isHidden = false
            }
        }else{
            self.detailLabelMaxHeightConstraint.constant = 0
            self.viewMaxHeightConstraint.constant = 0
            plusBtn.isHidden = true
            minusBtn.isHidden = true
            counterLbl.isHidden = true
            chagneBtn.isHidden = true
            refreshBtn.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
