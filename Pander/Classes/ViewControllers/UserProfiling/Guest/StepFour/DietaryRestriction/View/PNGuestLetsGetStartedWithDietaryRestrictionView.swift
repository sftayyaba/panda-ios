//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNGuestLetsGetStartedWithDietaryRestrictionView: UIView {

    @IBOutlet weak var vegetarianButton: UIButton!
    
    @IBOutlet weak var veganButton: UIButton!
    
    @IBOutlet weak var noPeanutesButton: UIButton!
    
    @IBOutlet weak var glutenFreeButton: UIButton!
    
    
    
    
    
    
    
    @IBOutlet var nextButton: UIButton!
    
    override func awakeFromNib() {
        self.configureNameTextField()
    }

    private func configureNameTextField(){
    }
    
    @IBAction func onSelectButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
