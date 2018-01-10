//
//  JNLoginTextFieldDelegate.swift
//  JobsNow
//
//  Created by $hery on 10/23/17.
//  Copyright © 2017 $hery. All rights reserved.
//

import Foundation
import UIKit

extension PNGuestLetsGetStartedWithEmailView : UITextFieldDelegate{
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.emailTextField.text != "" && self.passwordTextField.text != ""  {
            self.nextButton.titleLabel?.textColor = UIColor.black
            self.nextButton.isUserInteractionEnabled = true
        }else {
            self.nextButton.titleLabel?.textColor = UIColor.lightGray
            self.nextButton.isUserInteractionEnabled = false
        }
    }
}
