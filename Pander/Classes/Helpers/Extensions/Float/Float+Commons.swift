//
//  Float+Commons.swift
//  Pander
//
//  Created by Aamir Nazir on 30/03/2018.
//

import UIKit

extension Float {
    func stringValue(decimalPlaces: Int = 0) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
