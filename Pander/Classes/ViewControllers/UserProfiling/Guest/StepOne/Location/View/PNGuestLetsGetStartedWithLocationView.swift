//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedWithLocationView: UIView {

    @IBOutlet var zipCodeTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    
    override func awakeFromNib() {
        self.configureNameTextField()
    }

    private func configureNameTextField(){
        self.zipCodeTextField.delegate = self;
    }
}
