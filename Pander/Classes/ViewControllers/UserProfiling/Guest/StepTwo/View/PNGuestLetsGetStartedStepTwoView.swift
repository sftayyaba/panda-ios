//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedStepTwoView: UIView {

    @IBOutlet var cuisineTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    var textChangedCallback: ((String)->())?
    
    override func awakeFromNib() {
        self.configureTextFields()
        self.nextButton.isEnabled = false
    }
    
    private func configureTextFields(){
        self.cuisineTextField.delegate = self;
    }
    
    func textChanged(text: String){
        if let callback = textChangedCallback{
            callback(text)
        }
    }

}
