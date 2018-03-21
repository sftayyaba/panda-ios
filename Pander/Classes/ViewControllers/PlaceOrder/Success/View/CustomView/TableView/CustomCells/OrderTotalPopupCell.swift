//
//  OrderTotalPopupCell.swift
//  Pander
//
//  Created by Aamir Nazir on 20/03/2018.
//

import UIKit

class OrderTotalPopupCell: UITableViewCell {

    @IBOutlet weak var totalPriceLbl: UILabel!

    func setupCell(totalPrice: Float) {
        totalPriceLbl.text = String(format: "$%.2f", totalPrice)
    }
}
