//
//  PNOrderDetailPaymentTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailPaymentTableViewCell: UITableViewCell {

    
    public var didAddItemButtonCallback : (() -> Void)?
    var cart: PNCart!
    var ordrer: PNOrders!
    var totalPrice = Float()
    var indexPath = IndexPath()
    
    @IBOutlet weak var redPriceLabel: UILabel!
    @IBOutlet weak var greyPriceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    
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
    
    func setContent(cart: PNCart, order:PNOrders,indexPath: IndexPath){
        
        self.cart = cart
        self.ordrer = order
        self.indexPath = indexPath
        
        if let price = cart.price{
            self.redPriceLabel.text = price.format(f: "")
        }
        self.itemTitleLabel.text = cart.name

        counter = self.cart.quantity!
        self.cart.quantity = counter
        order.cart![indexPath.row] = self.cart!
        
        
        
        self.counterLbl.text = String(format: "%d",counter)
        if var price = cart.price{
            price = price * Float(counter)
            self.greyPriceLabel.text = price.format(f: "")
        }

        
        if cart.isSelected {
            self.viewMaxHeightConstraint.constant = 38
            plusBtn.isHidden = false
            minusBtn.isHidden = false
            counterLbl.isHidden = false
            chagneBtn.isHidden = false
            refreshBtn.isHidden = false

        }else {
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
        self.cart.quantity = counter
        self.ordrer.cart![self.indexPath.row] = self.cart!

        self.counterLbl.text = String(format: "%d",counter)
        if var price = cart.price{
            price = price * Float(counter)
            self.greyPriceLabel.text = price.format(f: "")
            
            
            if UserDefaults.standard.object(forKey: "detailTotalPrice") != nil{
                totalPrice = UserDefaults.standard.object(forKey: "detailTotalPrice") as! Float
                totalPrice = totalPrice + cart.price!
                UserDefaults.standard.set(totalPrice, forKey: "detailTotalPrice")
            }else {
                totalPrice = ordrer.total! + cart.price!
                UserDefaults.standard.set(totalPrice, forKey: "detailTotalPrice")
            }
            
            
            let counterDic : [String: Float] = ["TotalPrice":totalPrice]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderDetailPlus"), object: nil, userInfo: counterDic)
        }
    }
    
    @IBAction func minusBtntarget(_ sender: Any) {
        counter = counter - 1
        if counter < 1 {
            counter = 1
            self.counterLbl.text = String(format: "%d",counter)
        }else {
            self.cart.quantity = counter
            self.ordrer.cart![self.indexPath.row] = self.cart!

            self.counterLbl.text = String(format: "%d",counter)
            var price = greyPriceLabel.text?.floatValue()
            price = price! - cart.price!
            self.greyPriceLabel.text = price?.format(f: "")
            
            
            if UserDefaults.standard.object(forKey: "detailTotalPrice") != nil{
                totalPrice = UserDefaults.standard.object(forKey: "detailTotalPrice") as! Float
                totalPrice = totalPrice - cart.price!
                UserDefaults.standard.set(totalPrice, forKey: "detailTotalPrice")
            }else {
                totalPrice = ordrer.total! - cart.price!
                UserDefaults.standard.set(totalPrice, forKey: "detailTotalPrice")
            }
            
            let counterDic : [String: Float] = ["TotalPrice":totalPrice]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderDetailMinus"), object: nil, userInfo: counterDic)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension String {
    func floatValue() -> Float? {
        if let floatval = Float(self) {
            return floatval
        }
        return nil
    }
}
