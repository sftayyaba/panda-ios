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
        itemPriceLbl.text = "\(orderItem?.price ?? 0.0)"
    }

    func setupCell(cartItem: PNCart?) {
        itemNameLbl.text = cartItem?.name
        itemPriceLbl.text = "\(cartItem?.price ?? 0.0)"
    }
}
