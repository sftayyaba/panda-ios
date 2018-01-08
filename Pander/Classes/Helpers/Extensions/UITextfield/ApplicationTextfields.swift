//
//  ApplicationButtons.swift
//  Expo Mobile
//
//  Created by Onebyte LLC on 6/9/17.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UITextField: PropertyStoring {
    typealias T = UILabel?
    private struct CustomProperties {
        static var titleLabel : UILabel?
    }
    
    var titleLabel: UILabel? {
        get {
            return getAssociatedObject(&CustomProperties.titleLabel, defaultValue: CustomProperties.titleLabel)
        }
        set {
            return objc_setAssociatedObject(self, &CustomProperties.titleLabel, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func updateTextFieldLayoutWithBorderSize(borderWidth:CGFloat, cornerRadius:CGFloat, borderColor:UIColor) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(ApplicationNumberConstants.kTextfieldLeftPadding), height: self.frame.height))
        self.leftViewMode = .always
        self.layer.cornerRadius = self.frame.size.height/2.0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func updateTextFieldLayoutWithOnlyBottomBorderSize(borderWidth:CGFloat, borderColor:UIColor) {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        border.borderColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  1900, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func configure(backgroundColor: UIColor, borderColor: UIColor, textColor: UIColor, borderWidth: CGFloat, corners:UIRectCorner, cornerRadius: CGFloat) -> Void {
        if(cornerRadius>0)
        {
            self.borderStyle = .roundedRect
        }
        
        self.backgroundColor = backgroundColor
        
        self.textColor = textColor
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(ApplicationNumberConstants.kTextfieldLeftPadding), height: self.frame.height))
        self.leftViewMode = .always

        if(borderWidth>0){
            self.layer.borderWidth = borderWidth;
            self.layer.borderColor = borderColor.cgColor
        }
        
        if(cornerRadius>0){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            mask.frame = self.bounds
            self.layer.mask = mask
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
