//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedStepTwoView: UIView {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    override func awakeFromNib() {
        self.configureTextFields()
    }
    
    private func configureTextFields(){
        self.emailTextField.delegate = self;
    }
}
