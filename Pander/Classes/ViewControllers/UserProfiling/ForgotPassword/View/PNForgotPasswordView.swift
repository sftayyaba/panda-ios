//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNForgotPasswordView: PNBaseView {

    @IBOutlet var submitButton: UIButton!
    @IBOutlet var emailTextField: UITextField!

    
    override func awakeFromNib() {
        self.configureCreateAccountButton()
    }
    
    func configureCreateAccountButton() {
        
        self.submitButton.layer.cornerRadius = 5.0
        self.submitButton.layer.borderColor = UIColor.customRedColor().cgColor
    }
}
