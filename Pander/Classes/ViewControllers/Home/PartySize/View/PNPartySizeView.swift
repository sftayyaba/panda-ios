//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNPartySizeView: UIView {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    @IBOutlet var numberOfPeople: UILabel!

    @IBOutlet weak var findFriendswitch: UISwitch!

    @IBOutlet weak var facebookFriendSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedFriendsViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        self.configureTextFields()
        self.selectedFriendsViewHeight.constant = 0
        self.facebookFriendSearchViewHeight.constant = 0
    }
    
    private func configureTextFields(){
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        self.numberOfPeople.text = String(currentValue)
    }
    
    @IBAction func findFriendSwitchStates(sender: UISwitch) {
        
        if findFriendswitch.isOn == true{
            self.facebookFriendSearchViewHeight.constant = 200
        }
        if findFriendswitch.isOn == false{
            self.facebookFriendSearchViewHeight.constant = 0
        }
    }

}
