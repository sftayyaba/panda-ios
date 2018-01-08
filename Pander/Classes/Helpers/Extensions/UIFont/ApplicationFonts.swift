//
//  ApplicationColors.swift
//  Expo Mobile
//
//  Created by Onebyte LLC on 6/9/17.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import UIKit

struct ApplicationFontNames {
    static let kLatoRegular = "Avenir-Book";
    static let kLatoBold = "Avenir-Heavy";
}

struct ApplicationFontSizes {
    static let kNavigationTitleFontSize : CGFloat = 17.0;
    static let kTextfieldFontSize : CGFloat = 14.0;
    static let kDescriptionTextLabelFontSize : CGFloat = 14.0;
    static let kTextfieldTitleFontSize : CGFloat = 11.0;

}

extension UIFont {
    class func regularApplicationFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name:ApplicationFontNames.kLatoRegular, size: size)!
    }
    
    class func boldApplicationFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name:ApplicationFontNames.kLatoBold, size: size)!
    }
}
