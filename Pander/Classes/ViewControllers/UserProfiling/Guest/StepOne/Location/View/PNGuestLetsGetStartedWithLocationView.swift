//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedWithLocationView: UIView {

    @IBOutlet weak var confirmationLabel: UILabel!
    @IBOutlet var zipCodeTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    
    override func awakeFromNib() {
        self.configureNameTextField()
    }

    private func configureNameTextField(){
        self.zipCodeTextField.delegate = self;
    }
    
    func setNextButtonState() {
        if let text = zipCodeTextField.text {
            if !text.isEmpty && text.count >= 5{
                self.nextButton.setTitleColor(.black, for: .normal)
                self.nextButton.isUserInteractionEnabled = true
                return
            }
        }
        self.nextButton.setTitleColor(.lightGray, for: .normal)
        self.nextButton.isUserInteractionEnabled = false
    }
}
