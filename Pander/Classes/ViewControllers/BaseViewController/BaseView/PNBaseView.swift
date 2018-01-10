//
//  JNBaseView.swift
//  JobsNow
//
//  Created by Onebyte on 10/25/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import UIKit

class PNBaseView : UIView{
    
    //MARK: View Component Configuration Methods
    internal static func setRadiusToView(view: UIView, radius: CGFloat? = nil) {
        view.layer.cornerRadius = radius ?? view.frame.size.width / 2
    }
    
    //MARK: Text Label Configurations
    internal static func configureDescriptionLabel(label: UILabel){
        label.font = UIFont.regularApplicationFontOfSize(size: ApplicationFontSizes.kDescriptionTextLabelFontSize)
        label.textColor = UIColor.darkTextColor()
    }
    
    //MARK: TextField Configurations
    internal static func configureTextFieldLabel(label: UILabel){
        label.font = UIFont.regularApplicationFontOfSize(size: ApplicationFontSizes.kTextfieldTitleFontSize)
        label.textColor = UIColor.textFieldUnSelectedTitleColor()
    }
    
    internal static func configureTextField(textField: UITextField){
        textField.font = UIFont.regularApplicationFontOfSize(size: ApplicationFontSizes.kTextfieldFontSize)
        textField.configure(backgroundColor: UIColor.clear, borderColor: UIColor.clear, textColor: UIColor.darkTextColor(), borderWidth: 0, corners: UIRectCorner.allCorners, cornerRadius: 0)
        textField.updateTextFieldLayoutWithOnlyBottomBorderSize(borderWidth: 1, borderColor: UIColor.textFieldBottomBorderColor())
    }

    //MARK: Buttons Configuration
    internal static func configureButton(button: UIButton, target: AnyObject, action: Selector){
        button.configureRoundButton(backgroundColor: UIColor.mainButtonsBackgroundColor(), borderColor: UIColor.clear, borderRadius: 20, hasShadow: true, textColor: UIColor.mainButtonsTextColor(), shouldLeftPad: false, target: target, action: action)
    }
    
    internal static func configureBorderedButton(button: UIButton, target: AnyObject, action: Selector){
        button.configureRoundButton(backgroundColor: UIColor.borderButtonBackground(), borderColor: UIColor.borderButtonBorderColor(), borderRadius: 20, hasShadow: true, textColor: UIColor.borderButtonBorderColor(), shouldLeftPad: false, target: target, action: action)
    }
    
    internal static func configureTextButton(button: UIButton, target: AnyObject, action: Selector){
        button.configureRoundButton(backgroundColor: UIColor.clear, borderColor: UIColor.clear, borderRadius: 0, hasShadow: false, textColor: UIColor.textButtonsTextColor(), shouldLeftPad: false, target: target, action: action)
    }
}
