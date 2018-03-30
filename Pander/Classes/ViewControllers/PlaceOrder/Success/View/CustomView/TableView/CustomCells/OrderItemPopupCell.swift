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
        let unitPrice = orderItem?.unitPrice ?? 0.0
        let itemQuantity = orderItem?.qty ?? 1
        let totalPrice = unitPrice * Float(itemQuantity)

        itemNameLbl.text = orderItem?.name
        itemPriceLbl.text = totalPrice.stringValue(decimalPlaces: 2)
    }

    func setupCell(cartItem: PNCart?) {
        let unitPrice = cartItem?.price ?? 0.0
        let itemQuantity = cartItem?.quantity ?? 1
        let totalPrice = unitPrice * Float(itemQuantity)

        itemNameLbl.text = cartItem?.name
        itemPriceLbl.text = totalPrice.stringValue(decimalPlaces: 2)
    }
}
