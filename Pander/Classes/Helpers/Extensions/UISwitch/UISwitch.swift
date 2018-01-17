//
//  UISwitch.swift
//  Pander
//
//  Created by Shery on 11/01/2018.
//

import Foundation
import UIKit

@IBDesignable class BigSwitch: UISwitch {
    
    @IBInspectable var scaleX : CGFloat = 1{
        didSet{
            setup()
        }
    }

    @IBInspectable var scaleY : CGFloat = 1{
        didSet{
            setup()
        }
    }

    //from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    //from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
        super.prepareForInterfaceBuilder()
    }
    
    
}
