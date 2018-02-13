//
//  PNLocationPhoneNumberFieldFormatter.swift
//  Pander
//
//  Created by Abdul Sami on 14/02/2018.
//

import Foundation
import UIKit

extension PNLocationView: UITextFieldDelegate{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
//            let updatedText = text.replacingCharacters(in: textRange,
//                                                       with: string)
            // All digits entered
            if (range.location == 12) {
                return false
            }
            
            
            // Auto-add hyphen before appending 4rd or 8th digit
            if (range.length == 0 &&
                (range.location == 3 || range.location == 7)) {
                textField.text = String (format: "%@-%@", textField.text! , string)
                return false;
            }
            
            // Delete hyphen when deleting its trailing digit
            if (range.length == 1 &&
                (range.location == 4 || range.location == 8))  {
                var customRange = range
                customRange.location = customRange.location-1;
                customRange.length = 2;
                textField.text = textField.text?.replacingCharacters(in: Range(customRange, in: textField.text!)!, with: "")
                return false;
            }
        }
        return true;
    }
}
