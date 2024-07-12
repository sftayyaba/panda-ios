//
//  ApplicationColors.swift
//  Expo Mobile
//
//  Created by Onebyte LLC on 6/9/17.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    class func navigationColor() -> UIColor{
        return UIColor.customBlueColor()
    }
    
    class func backgroundColor() -> UIColor{
        return UIColor(red:236.0/255.0, green:235.0/255.0 ,blue:241.0/255.0 , alpha:1.00)
    }


    
    class func customGrayColor() -> UIColor{
        return UIColor(red:135.0/255.0, green:135.0/255.0 ,blue:135.0/255.0 , alpha:1.00)
    }
    
    class func customGreenColor() -> UIColor{
        return UIColor(red:0.55, green:0.78, blue:0.25, alpha:1)
    }

    class func customBlueColor() -> UIColor{
        return UIColor(red:0.25, green:0.71, blue:0.9, alpha:1)
    }
    
    class func customOrangeColor() -> UIColor{
        return UIColor(red:0.99, green:0.57, blue:0.39, alpha:1)
    }
    
    class func customRedColor() -> UIColor{
        return UIColor(red:1, green:0.16, blue:0.16, alpha:1)
    }
    
    class func menuGrayColor() -> UIColor{
        return UIColor(red:85.0/255.0, green:85.0/255.0 ,blue:85.0/255.0 , alpha:1.00)
    }
    
    class func purpleBodyColor() -> UIColor{
        return UIColor(red:65.0/255.0, green:107.0/255.0 ,blue:153.0/255.0 , alpha:1.00)
    }
    
    class func cellBackgroundColor() -> UIColor{
        return UIColor(red:239.0/255.0, green:239.0/255.0 ,blue:239.0/255.0 , alpha:1.00)
    }

    class func cellSelectedTextColor() -> UIColor{
        return UIColor(red:254.0/255.0, green:192.0/255.0 ,blue:198.0/255.0 , alpha:1.00)
    }

    class func tableViewBackgroundColor() -> UIColor{
        return UIColor(red:235.0/255.0, green:235.0/255.0 ,blue:235.0/255.0 , alpha:1.00)
    }

    //MARK: Text Colors
    class func darkTextColor() -> UIColor{
        return UIColor(red:0.36, green:0.36, blue:0.36, alpha:1)
    }
    class func greenTextColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    
    
    //MARK: TextFields Colors
    class func textFieldBottomBorderColor() -> UIColor{
        return UIColor(red:0.36, green:0.36, blue:0.36, alpha:0.2)
    }
    class func textFieldSelectedTitleColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    class func textFieldUnSelectedTitleColor() -> UIColor{
        return UIColor.darkTextColor()
    }
    
    
    //MARK: Buttons Colors
    class func mainButtonsBackgroundColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    class func mainButtonsTextColor() -> UIColor{
        return UIColor.white
    }
    
    
    class func textButtonsTextColor() -> UIColor{
        return UIColor(red:0.25, green:0.71, blue:0.9, alpha:1)
    }
    
    
    class func borderButtonBackground() -> UIColor{
        return UIColor.white
    }
    class func borderButtonBorderColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    class func borderButtonTextColor() -> UIColor{
        return UIColor.customGreenColor()
    }


    //MARK: TabBar Buttons Colors
    class func tabBarGradientStartColor() -> UIColor{
        return UIColor.customBlueColor()
    }
    class func tabBarGradientEndColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    
    //MARK: Job Status Colors
    class func filledJobIndicatorColor() -> UIColor{
        return UIColor.customGreenColor()
    }
    
    class func partiallyFilledJobIndicatorColor() -> UIColor{
        return UIColor.customOrangeColor()
    }
    
    class func openJobIndicatorColor() -> UIColor{
        return UIColor.customRedColor()
    }
    
    //MARK: Tags  color
    class func customTagsBackgroundColor() -> UIColor{
        return UIColor(red:249.0/255.0, green:249.0/255.0 ,blue:249.0/255.0 , alpha:1.00)
    }

}

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}
