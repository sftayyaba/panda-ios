//
//  PNFavoriteDishesTextFieldDelegate.swift
//  Pander
//
//  Created by umaid naeem on 2/17/18.
//

import Foundation
import UIKit


extension PNFavoriteDishesView : UITextFieldDelegate {
    
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
