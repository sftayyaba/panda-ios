//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderPaymentTableViewCell: UITableViewCell {

    public var didAddItemButtonCallback : (() -> Void)?
    public var didRemoveItemButtonCallback : ((PNOrderDish) -> Void)?
    public var didChangedItemQuantity : (() -> Void)?

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
    
    var counter = 1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailLabelMaxHeightConstraint.constant = 0
        self.viewMaxHeightConstraint.constant = 0
        plusBtn.isHidden = true
        minusBtn.isHidden = true
        counterLbl.isHidden = true
        chagneBtn.isHidden = true
        refreshBtn.isHidden = true
    }

    
    func setContent(dish: PNOrderDish){
        self.dish = dish
        self.counter = (PNOrderManager.sharedInstance.generatedOrder?.recommendation?.dishQuantity(dishId: dish.id)) ?? 1
        let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.totalPriceFor(dishId: dish.id)?.round(decimalPlace: 3)
        let blackUnitPrice = dish.unitPrice ?? 0.00
        let greyUnitPrice = totalPrice ?? 0.0
        redPriceLabel.text = "$\(String(format: "%.2f", blackUnitPrice))"
        greyPriceLabel.text = "$\(String(format: "%.2f", greyUnitPrice))"

        itemTitleLabel.text = dish.name
        detailLabel.text = dish.descriptionValue

        
        if dish.isSelected{
            if dish.descriptionValue != "" {
                self.detailLabelMaxHeightConstraint.constant = 200
                self.viewMaxHeightConstraint.constant = 40
                plusBtn.isHidden = false
                minusBtn.isHidden = false
                counterLbl.isHidden = false
                chagneBtn.isHidden = false
                refreshBtn.isHidden = false
                
            }else{
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
    
    @IBAction func plusBtnTarget(_ sender: Any) {
        counter = counter + 1
        PNOrderManager.sharedInstance.generatedOrder?.recommendation?.increaseDishQuantity(dishId: dish.id)
        let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.totalPriceFor(dishId: dish.id)
        redPriceLabel.text = "$\(totalPrice ?? 0.0)"
        counterLbl.text = String(format: "%d", counter)

        didChangedItemQuantity?()
    }
    
    @IBAction func minusBtntarget(_ sender: Any) {
        counter = counter - 1
        if counter <= 0 {
            let alertController = UIAlertController(title: "", message: "Are you sure you want to remove the item?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                self.counter = 0
                self.counterLbl.text = String(format: "%d",self.counter)
                if let callBack = self.didRemoveItemButtonCallback{
                    callBack(self.dish)
                }
            }
            
            let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                self.counter = 1
                self.counterLbl.text = String(format: "%d",self.counter)
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }else {
            PNOrderManager.sharedInstance.generatedOrder?.recommendation?.decreaseDishQuantity(dishId: dish.id)
            let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.totalPriceFor(dishId: dish.id)
            redPriceLabel.text = "$\(totalPrice ?? 0.0)"
            counterLbl.text = String(format: "%d",counter)
 
            didChangedItemQuantity?()
        }
    }
    
    
    
    @IBAction func changeTarget(_ sender: Any) {
        if let callBack = didAddItemButtonCallback{
            callBack()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
