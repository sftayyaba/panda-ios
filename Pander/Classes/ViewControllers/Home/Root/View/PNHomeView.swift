//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNHomeView: UIView {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var numberOfPeople: UILabel!
    
    @IBOutlet var arrowUpImageView: UIView!
    @IBOutlet var arrowUpButton: UIButton!

    @IBOutlet var searchView: UIView!

    @IBOutlet var allPropertiesView: UIView!

    @IBOutlet weak var findFriendswitch: UISwitch!
    
    @IBOutlet weak var showAllPropertiesViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.configureTextFields()
    }
    
    private func configureTextFields(){
    }
    
    @IBAction func closeButtonTapped() {
        self.allPropertiesView.isHidden = true
        self.searchView.isHidden = false
        self.showAllPropertiesViewHeight.constant = 60
    }
    
    @IBAction func searchButtonTapped() {
        self.allPropertiesView.isHidden = false
        self.searchView.isHidden = true
        self.showAllPropertiesViewHeight.constant = 470
    }
}
