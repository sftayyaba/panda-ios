//
//  ApplicationButtons.swift
//  Expo Mobile
//
//  Created by Onebyte LLC on 6/9/17.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func configureRoundButton(backgroundColor: UIColor, borderColor: UIColor, borderRadius: CGFloat, hasShadow: Bool, textColor: UIColor, shouldLeftPad: Bool , target: AnyObject, action: Selector) -> Void {
        
        self.backgroundColor = backgroundColor
        
        self.setTitleColor(textColor, for: .normal)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        
        //self.layer.masksToBounds = true
        
        self.layer.cornerRadius = borderRadius
        
        if(hasShadow){
//            let layer = UIView(frame:CGRect)
//            layer.layer.cornerRadius = 100
//            layer.backgroundColor = backgroundColor
//            layer.layer.shadowOffset = CGSize(width: 0, height: 2)
//            layer.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.11).cgColor
//            layer.layer.shadowOpacity = 1
//            layer.layer.shadowRadius = 2
//            self.addSubview(layer)
            
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.11).cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 2
        }
        
        self.addTarget(target, action: action, for: .touchUpInside)
    }
  
    func updateButtonLayout() -> UIButton {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.backgroundColor = UIColor.red.cgColor
        return self
    }  
}
