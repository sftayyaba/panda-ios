//
//  JNLoginTextFieldDelegate.swift
//  JobsNow
//
//  Created by $hery on 10/23/17.
//  Copyright © 2017 $hery. All rights reserved.
//

import Foundation
import UIKit

extension PNGuestLetsGetStartedStepThreeView : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        self.textChanged(text: updatedText)
        return true;
    }
    
    
}
