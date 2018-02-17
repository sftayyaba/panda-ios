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
    
    func setNextButtonState() {
        if let text = nameTextField.text {
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
