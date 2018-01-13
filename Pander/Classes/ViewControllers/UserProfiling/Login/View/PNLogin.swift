//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNLoginView: PNBaseView {

    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
    override func awakeFromNib() {
        self.configureCreateAccountButton()
    }
    
    func configureCreateAccountButton() {
        
        self.createAccountButton.layer.cornerRadius = 5.0
        self.createAccountButton.layer.borderColor = UIColor.customRedColor().cgColor
    }
}
