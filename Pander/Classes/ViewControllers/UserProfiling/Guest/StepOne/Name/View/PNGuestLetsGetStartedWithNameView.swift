//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedWithNameView: PNBaseView {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    override func awakeFromNib() {
        self.configureNameTextField()
    }
    
    private func configureNameTextField(){
        self.nameTextField.delegate = self;
    }
}
