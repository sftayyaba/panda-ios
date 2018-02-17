//
//  UINavigationBar.swift
//  MomMatters
//
//  Created by Shery on 24/03/2017.
//  Copyright © 2017 1byte. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    func showNavigationBar(text:String) {
        let label = UILabel(frame: CGRect(x:10.0, y:0.0, width:50.0, height:40.0))
//        label.font = UIFont(name: ApplicationFonts.kNavigationFonts, size: 20.0)
        label.numberOfLines = 2
        label.text = text
        label.textColor = UIColor.black
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.center
        self.titleView = label
        self.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}



