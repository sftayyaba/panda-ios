//
//  UIView+Commons.swift
//  Pander
//
//  Created by Aamir Nazir on 19/03/2018.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.5
    }

    func roundCorner(radius: CGFloat) {
        layer.cornerRadius = radius
    }

    func addBorder(width: CGFloat = 1.0, color: UIColor = .lightGray) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
