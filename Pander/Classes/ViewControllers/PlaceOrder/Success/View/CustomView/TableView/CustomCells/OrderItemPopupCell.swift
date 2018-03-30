//
//  OrderItemPopupCell.swift
//  Pander
//
//  Created by Aamir Nazir on 20/03/2018.
//

import UIKit

class OrderItemPopupCell: UITableViewCell {

    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    func setupCell(orderItem: PNOrderDish?) {
        itemNameLbl.text = orderItem?.name
        let itemQuantity = orderItem?.qty ?? 0
        let quantityFloat = Float(itemQuantity)
        let itemRoundedPrice = quantityFloat * (orderItem?.price ?? 0.0)
        itemPriceLbl.text = "$\(String(format: "%.2f", itemRoundedPrice))"
    }

    func setupCell(cartItem: PNCart?) {
        itemNameLbl.text = cartItem?.name
        let cartItemRoundedPrice = cartItem?.price ?? 0.0
        itemPriceLbl.text = "$\(String(format: "%.2f", cartItemRoundedPrice))"
    }
}
