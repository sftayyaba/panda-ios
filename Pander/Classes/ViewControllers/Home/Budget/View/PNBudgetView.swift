//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import TextFieldEffects
import AAPickerView

class PNBudgetView: UIView {
    
    @IBOutlet weak var selectedCardLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet weak var labelTapToAdd: UILabel!

    @IBOutlet weak var budgetPerPersonLabel: UILabel!
    @IBOutlet weak var budgetPerPersonSlider: UISlider!
    @IBOutlet var cardNumberTextField:UITextField!

    @IBOutlet var expiryMonthTextField: AAPickerView!
    @IBOutlet var expiryYearTextField: AAPickerView!
    @IBOutlet var cvvTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var zipCodeTextField: UITextField!

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
        
        self.budgetPerPersonSlider.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.normal)
        
        self.budgetPerPersonSlider.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.highlighted)
        
        self.budgetPerPersonSlider.setThumbImage(UIImage.circle(diameter: 12.0, color: UIColor.red), for: UIControlState.focused)
        
        
        self.budgetPerPersonSlider.setValue(Float(PNUserManager.sharedInstance.budgetPerPerson), animated: false)
        self.budgetPerPersonLabel.text = "$\(PNUserManager.sharedInstance.budgetPerPerson)"
        
    }
    
    private func configureTextFields(){
        self.showTableViewHeight.constant = 35
        self.newAddressView.isHidden = true
        self.storeAddressView.isHidden = true
    }
    
    @IBAction func budgetPerPersonValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value.rounded())
        
        if currentValue % 5 != 0 {
           return
        }
        
        self.budgetPerPersonLabel.text = "$\(currentValue)"
        
        sender.setValue(Float(currentValue), animated: false)
        
        
        PNUserManager.sharedInstance.budgetPerPerson = currentValue
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
            self.labelTapToAdd.text = "TAP TO ADD"
        }else {
            //            self.storeAddressButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 35
            self.newAddressButton.isSelected = false
            self.newAddressView.isHidden = false
            self.arrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
            self.labelTapToAdd.text = "HIDE"
        }
    }
}
