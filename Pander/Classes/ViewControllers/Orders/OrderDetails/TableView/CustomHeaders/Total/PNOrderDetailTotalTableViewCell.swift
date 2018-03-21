//
//  PNOrderDetailTotalTableViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailTotalTableViewCell: UITableViewCell {

    public var editAndReorderButtonCallback : (() -> Void)?
    public var reorderButtonCallback : (() -> Void)?
    
    @IBOutlet var editAndReorderBtn: UIButton!
    @IBOutlet var reorderBtn: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var order : PNOrders!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editAndReorderAction(_ sender: Any) {
        if let callBack = editAndReorderButtonCallback{
            callBack()
        }
    }
    
    
    
    @IBAction func reorderAction(_ sender: Any) {
        if let callBack = reorderButtonCallback{
            callBack()
        }

    }
    
    
    
    func setContent(cuisine:String,order:PNOrders) {
        
        self.order = order
        
        NotificationCenter.default.addObserver(self, selector: #selector(plusObserver), name: NSNotification.Name(rawValue: "orderDetailPlus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minusObserver), name: NSNotification.Name(rawValue: "orderDetailMinus"), object: nil)

        
        
        if UserDefaults.standard.object(forKey: "detailTotalPrice") != nil{
           let  totalPrice = UserDefaults.standard.object(forKey: "detailTotalPrice") as! Float
            self.totalLabel.text = totalPrice.format(f: "")
        }else {
            self.totalLabel.text = (order.total?.format(f: ""))!
            UserDefaults.standard.set(order.total!, forKey: "detailTotalPrice")
        }
        
        
        if cuisine == "0" {
            self.editAndReorderBtn.setTitle("Contact Restaurant", for: .normal)
            self.reorderBtn.setTitle("Edit & Reorder", for: .normal)
        }else {
            self.editAndReorderBtn.setTitle("Edit & Reorder", for: .normal)
            self.reorderBtn.setTitle("Re-Order", for: .normal)
        }
    }
    
    
    
    @objc func plusObserver(notification:NSNotification) {
        
        if let counterPrice = notification.userInfo?["TotalPrice"] as? Float {
            self.totalLabel.text = counterPrice.format(f: "")
        }
    }
    
    @objc func minusObserver(notification:NSNotification) {
        
        if let counterPrice = notification.userInfo?["TotalPrice"] as? Float {
            self.totalLabel.text = counterPrice.format(f: "")
        }
    }
}
