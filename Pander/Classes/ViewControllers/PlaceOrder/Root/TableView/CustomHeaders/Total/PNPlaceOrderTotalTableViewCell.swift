//
//  PNPlaceOrderImageSliderTableViewCell.swift
//  Pander
//
//  Created by Shery on 04/02/2018.
//

import UIKit

class PNPlaceOrderTotalTableViewCell: UITableViewCell {

    
    public var editAndReorderButtonCallback : (() -> Void)?
    public var newSuggestionButtonCallback : (() -> Void)?
    
    @IBOutlet var totalPriceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func getNewSuggestionTapped(_ sender: Any) {
        if let callBack = newSuggestionButtonCallback{
            callBack()
        }
    }
    
    
    @IBAction func reORdertapped(_ sender: Any) {
        if let callBack = editAndReorderButtonCallback{
            callBack()
        }
    }
    
    
    
    func setContent()  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(plusObserver), name: NSNotification.Name(rawValue: "plus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minusObserver), name: NSNotification.Name(rawValue: "minus"), object: nil)

        
        if let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
            return result + dish.price!
        }){
            self.totalPriceLbl.text = "$"+totalPrice.format(f: "")
        }

    }
    
    
    @objc func plusObserver(notification:NSNotification) {
        
        if let dish = notification.userInfo?["dish"] as? PNOrderDish {
            let unitPrice = dish.unitPrice
            
            if UserDefaults.standard.object(forKey: "myTotalPrice") != nil{
                var totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
                totalPrice = totalPrice + unitPrice!
                UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
                self.totalPriceLbl.text =  String(totalPrice)
                self.totalPriceLbl.text = "$\(String(describing: self.totalPriceLbl.text!))"
                
            }else {
                if var totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
                    print(result + dish.unitPrice!)
                    return result + dish.unitPrice!
                }){
                    totalPrice = totalPrice + unitPrice!
                    
                    self.totalPriceLbl.text =  String(totalPrice)
                    
                    self.totalPriceLbl.text = "$\(String(describing: self.totalPriceLbl.text!))"
                    UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
                }
            }
        }
    }
    
    @objc func minusObserver(notification:NSNotification) {
        
        if let dish = notification.userInfo?["dish"] as? PNOrderDish {
            let unitPrice = dish.unitPrice
            var totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
            totalPrice = totalPrice - unitPrice!
            self.totalPriceLbl.text =  String(totalPrice)
            self.totalPriceLbl.text = "$\(String(describing: self.totalPriceLbl.text!))"
            UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
            
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
