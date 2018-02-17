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
       setNextButtonState()
    }
}
