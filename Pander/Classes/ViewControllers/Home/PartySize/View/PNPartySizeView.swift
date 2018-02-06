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

    @IBOutlet weak var switchButton: UIButton!

    @IBOutlet weak var facebookFriendSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedFriendsViewHeight: NSLayoutConstraint!
    @IBOutlet var facebookFriendSearchView: UIView!

    override func awakeFromNib() {
        self.configureTextFields()
//        self.selectedFriendsViewHeight.constant = 0
        
        self.facebookFriendSearchViewHeight.constant = 0
        self.facebookFriendSearchView.isHidden = true
    }
    
    private func configureTextFields(){
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        self.numberOfPeople.text = String(currentValue)
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        
        if !self.switchButton.isSelected {
            self.facebookFriendSearchViewHeight.constant = 200
            self.facebookFriendSearchView.isHidden = false
            self.switchButton.isSelected = true
        }else {
            self.facebookFriendSearchViewHeight.constant = 0
            self.facebookFriendSearchView.isHidden = true
            self.switchButton.isSelected = false
        }
    }
}
