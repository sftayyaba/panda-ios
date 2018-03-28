//
//  PNUtils.swift
//  Pander
//
//  Created by Aamir Nazir on 20/03/2018.
//

import UIKit

extension Date {
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}

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
