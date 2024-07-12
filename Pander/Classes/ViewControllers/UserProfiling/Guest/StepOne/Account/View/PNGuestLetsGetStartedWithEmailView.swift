//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedWithEmailView: UIView {

    @IBOutlet weak var mainTitleText: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    override func awakeFromNib() {
        self.configureTextFields()
    }
    
    private func configureTextFields(){
        self.emailTextField.delegate = self;
        self.passwordTextField.delegate = self;
    }
    
    func setNextButtonState() {
        if let email = emailTextField.text , let password = passwordTextField.text{
            if !email.isEmpty && email.isEmail && password.count >= 5{
                self.nextButton.setTitleColor(.black, for: .normal)
                self.nextButton.isUserInteractionEnabled = true
                return
            }
        }
        self.nextButton.setTitleColor(.lightGray, for: .normal)
        self.nextButton.isUserInteractionEnabled = false
    }
}
