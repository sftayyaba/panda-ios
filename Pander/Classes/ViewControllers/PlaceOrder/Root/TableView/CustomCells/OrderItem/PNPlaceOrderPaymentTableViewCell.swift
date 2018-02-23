//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderPaymentTableViewCell: UITableViewCell {

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
        self.detailLabelMaxHeightConstraint.constant = 0
        self.viewMaxHeightConstraint.constant = 0
        plusBtn.isHidden = true
        minusBtn.isHidden = true
        counterLbl.isHidden = true
        chagneBtn.isHidden = true
        refreshBtn.isHidden = true
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
            self.detailLabelMaxHeightConstraint.constant = 200
            self.viewMaxHeightConstraint.constant = 40
            plusBtn.isHidden = false
            minusBtn.isHidden = false
            counterLbl.isHidden = false
            chagneBtn.isHidden = false
            refreshBtn.isHidden = false
       }
    }
    
    @IBAction func plusBtnTarget(_ sender: Any) {
        counter = counter + 1
        self.counterLbl.text = String(format: "%d",counter)
        let dishDic : [String: PNOrderDish] = ["dish":dish]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "plus"), object: nil, userInfo: dishDic)
    }
    
    @IBAction func minusBtntarget(_ sender: Any) {
        counter = counter - 1
        if counter < 0 {
            counter = 0
            self.counterLbl.text = String(format: "%d",counter)
//            let dishDic : [String: PNOrderDish] = ["dish":dish]
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "plus"), object: nil, userInfo: dishDic)
        }else {
            self.counterLbl.text = String(format: "%d",counter)
            let dishDic : [String: PNOrderDish] = ["dish":dish]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "minus"), object: nil, userInfo: dishDic)
        }
    }
    
    
    
    @IBAction func changeTarget(_ sender: Any) {
        if let callBack = didAddItemButtonCallback{
            callBack()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        dish.isSelected = selected
//        if dish.isSelected{
//            self.detailLabelMaxHeightConstraint.constant = 200
//        }else{
//            self.detailLabelMaxHeightConstraint.constant = 0
//        }
        // Configure the view for the selected state
    }
    
}
