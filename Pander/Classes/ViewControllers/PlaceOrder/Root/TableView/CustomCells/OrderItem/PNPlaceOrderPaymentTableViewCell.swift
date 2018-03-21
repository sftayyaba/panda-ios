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
    
    var dish: PNOrderDish!
    var totalPrice = Float()
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
        if let price = dish.price{
            self.redPriceLabel.text = "$"+price.format(f: "")
            self.greyPriceLabel.text = "$"+price.format(f: "")
        }
        
        
        counter = self.dish.qty!
        self.counterLbl.text = String(format: "%d",counter)
        if var price = dish.price{
            price = price * Float(counter)
            self.greyPriceLabel.text = "$"+price.format(f: "")
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
//        self.redPriceLabel.text = self.redPriceLabel.text?.components(separatedBy: "$")[1]
//        self.counterLbl.text = String(format: "%d",counter)
//        let dishDic : [String: PNOrderDish] = ["dish":dish]
//        let alreadyprice = (self.redPriceLabel.text! as NSString).floatValue
//
//        self.greyPriceLabel.text =  String(alreadyprice + dish.unitPrice!)
//        self.greyPriceLabel.text = "$\(self.redPriceLabel.text!)"
//        dish.price = alreadyprice + dish.price!
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "plus"), object: nil, userInfo: dishDic)
        
        self.dish.qty = counter

        var price = dish.unitPrice!
        self.counterLbl.text = String(format: "%d",counter)
        self.redPriceLabel.text = String(format: "$%.2f", price)
        price =  price * Float(counter)
        self.greyPriceLabel.text = price.format(f: "")
        
        
        if UserDefaults.standard.object(forKey: "myTotalPrice") != nil{
            totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
            totalPrice = totalPrice + self.dish.price!
            UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
        }else {
            if let detailtotalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
                print(result + dish.unitPrice!)
                return result + dish.unitPrice!
            }){
                totalPrice = detailtotalPrice + self.dish.price!
                UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
            }
        }
        
        let dishDic : [String: Float] = ["dish":totalPrice]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "plus"), object: nil, userInfo: dishDic)

        
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
            
            self.dish.qty = counter
            self.counterLbl.text = String(format: "%d",counter)
            var price = greyPriceLabel.text?.floatValue()
            price = price! - dish.unitPrice!
            self.greyPriceLabel.text = price?.format(f: "")
            
            if UserDefaults.standard.object(forKey: "myTotalPrice") != nil{
                totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
                totalPrice = totalPrice - dish.price!
                UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
            }else {
                
            }
            
            
            
            let dishDic : [String: Float] = ["dish":totalPrice]

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
    }
    
}
