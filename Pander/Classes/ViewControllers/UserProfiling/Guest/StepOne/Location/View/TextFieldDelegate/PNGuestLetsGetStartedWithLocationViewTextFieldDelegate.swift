//
//  JNLoginTextFieldDelegate.swift
//  JobsNow
//
//  Created by $hery on 10/23/17.
//  Copyright © 2017 $hery. All rights reserved.
//

import Foundation
import UIKit

extension PNGuestLetsGetStartedWithLocationView : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.zipCodeTextField.text != "" {
            self.nextButton.titleLabel?.textColor = UIColor.black
            self.nextButton.isUserInteractionEnabled = true
        }else {
            self.nextButton.titleLabel?.textColor = UIColor.lightGray
            self.nextButton.isUserInteractionEnabled = false
        }
    }
}
