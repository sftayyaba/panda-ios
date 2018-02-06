//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import TextFieldEffects

class PNBudgetView: UIView {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    @IBOutlet private var cardNumberTextField: [TextFieldEffects]!

    @IBOutlet var arrowImageView: UIImageView!

    @IBOutlet var numberOfPeople: UILabel!
    
    @IBOutlet var arrowUpImageView: UIView!
    @IBOutlet var arrowUpButton: UIButton!

    @IBOutlet var storeAddressView: UIView!

    @IBOutlet var newAddressView: UIView!

    @IBOutlet weak var storeAddressButton: UIButton!
    
    @IBOutlet weak var newAddressButton: UIButton!

    @IBOutlet weak var showTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showNewAddressViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        self.configureTextFields()
    }
    
    private func configureTextFields(){
        self.showTableViewHeight.constant = 35
        self.newAddressView.isHidden = true
        self.storeAddressView.isHidden = true
//        self.newAddressButton.isSelected = true
    }
    
    @IBAction func showStoredAddressButtonTapped() {
        
        if !self.storeAddressButton.isSelected {
        self.storeAddressView.isHidden = false
        self.newAddressView.isHidden = true
        self.showTableViewHeight.constant = 200
        self.storeAddressButton.isSelected = true
        self.arrowImageView.image = UIImage(named: "Arrow - Big - Up - Black")
            
        }else {
//            self.storeAddressButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 35
            self.storeAddressButton.isSelected = false
            self.arrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
        }
    }
    
    @IBAction func showNewAddressButtonTapped() {
        
        if !self.newAddressButton.isSelected {
            self.newAddressView.isHidden = true
            self.newAddressButton.isSelected = true
            
        }else {
            //            self.storeAddressButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 35
            self.newAddressButton.isSelected = false
            self.newAddressView.isHidden = false
            self.arrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
        }
    }
}
