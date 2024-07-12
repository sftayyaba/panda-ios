//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import TextFieldEffects

class PNDeliveryView: UIView {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    @IBOutlet private var cardNumberTextField: [TextFieldEffects]!

    @IBOutlet var dateArrowImageView: UIImageView!
    @IBOutlet var timeArrowImageView: UIImageView!

    @IBOutlet var numberOfPeople: UILabel!
    
    @IBOutlet var deliveryLabel: UILabel!

    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet var arrowUpImageView: UIView!
    @IBOutlet var arrowUpButton: UIButton!

    @IBOutlet var storeAddressView: UIView!

    @IBOutlet var newAddressView: UIView!

    @IBOutlet weak var selectTimeButton: UIButton!
    
    @IBOutlet weak var selectDateButton: UIButton!

    @IBOutlet weak var showTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showNewAddressViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        self.configureTextFields()
    }
    
    private func configureTextFields(){
        self.showTableViewHeight.constant = 10
        self.newAddressView.isHidden = true
        self.storeAddressView.isHidden = true
       // self.selectTimeButton.isSelected = true
    }
    
    @IBAction func selectDateButtonTapped() {
        
        if !self.selectDateButton.isSelected {
        self.storeAddressView.isHidden = false
        self.newAddressView.isHidden = true
        self.showTableViewHeight.constant = 300
        self.selectDateButton.isSelected = true
//        self.selectTimeButton.isSelected = true
        self.dateArrowImageView.image = UIImage(named: "Arrow - Big - Up - Black")
        self.timeArrowImageView.image = UIImage(named: "Arrow - Big - down - Black")

        }else {
//            self.storeAddressButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 10
            self.selectDateButton.isSelected = false
            self.dateArrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
        }
    }
    
    @IBAction func selectTimeButtonTapped() {
        
        if !self.selectTimeButton.isSelected {
            self.newAddressView.isHidden = false
            self.selectTimeButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 10
            self.selectDateButton.isSelected = false
            self.dateArrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
            self.timeArrowImageView.image = UIImage(named: "Arrow - Big - Up - Black")

        }else {
            //            self.storeAddressButton.isSelected = true
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 10
            self.selectTimeButton.isSelected = false
            self.newAddressView.isHidden = true
            self.timeArrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
            self.dateArrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
        }
    }
}
