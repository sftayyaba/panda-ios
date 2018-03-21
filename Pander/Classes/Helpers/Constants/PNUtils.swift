//
//  PNUtils.swift
//  Pander
//
//  Created by Aamir Nazir on 20/03/2018.
//

import UIKit

class PNUtils: NSObject {
    static func calculateTotalPrice(orders: [PNOrderDish]?) -> Float {
        let totalPrice = (orders?.reduce(0.0) { $0 + ($1.price ?? 0.0) }) ?? 0.0

        return totalPrice
    }

    static func calculateTotalPrice(orders: [PNCart]?) -> Float {
        let totalPrice = (orders?.reduce(0.0) { $0 + ($1.price ?? 0.0) }) ?? 0.0

        return totalPrice
    }
}
