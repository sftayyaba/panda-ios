//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import TextFieldEffects
import AAPickerView

class PNLocationView: UIView {
    
    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var deliverto : UILabel!
    @IBOutlet weak var streetAddressField: HoshiTextField!
    @IBOutlet weak var phoneNumberField: HoshiTextField!
    @IBOutlet weak var stateField: AAPickerView!
    @IBOutlet weak var zipCodeField: HoshiTextField!
    @IBOutlet weak var unit_numberField: HoshiTextField!
    @IBOutlet weak var cityField: HoshiTextField!
    @IBOutlet weak var addressNickNameField: HoshiTextField!
    @IBOutlet weak var labelTapToAdd: UILabel!

    @IBOutlet weak var addNewAddressButton: UIButton!
    
    
    @IBOutlet weak var stateTextFields: AAPickerView!

    @IBOutlet private var cardNumberTextField: [TextFieldEffects]!

    @IBOutlet var arrowImageView: UIImageView!


    @IBOutlet var storeAddressView: UIView!

    @IBOutlet var newAddressView: UIView!

    @IBOutlet weak var storeAddressButton: UIButton!
    
    @IBOutlet weak var newAddressButton: UIButton!

//    @IBOutlet weak var showTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showNewAddressViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        self.configureTextFields()
        self.configureStateTextFields()
        self.phoneNumberField.delegate = self
        self.zipCodeField.delegate = self
         self.arrowImageView.image = UIImage(named: "Arrow - Big - Up - Black")
        self.storeAddressButton.isSelected = true
    }
    
    func configureStateTextFields() {
        stateTextFields.pickerType = .StringPicker
        
        let stringData = ApplicationLocalArrays.kStates
        stateTextFields.stringPickerData = stringData
        stateTextFields.pickerRow.font = UIFont(name: "AvenirNext-Regular", size: 12)
        
        stateTextFields.toolbar.barTintColor = .darkGray
        stateTextFields.toolbar.tintColor = .black
        
        stateTextFields.stringDidChange = { index in
            
            self.stateTextFields.text = stringData[index]
        }
    }
    
    
    func refreshForm(){
        
        self.addressNickNameField.text = ""
        self.streetAddressField.text = ""
        self.cityField.text = ""
        self.unit_numberField.text = ""
        self.zipCodeField.text = ""
        self.phoneNumberField.text = ""
        self.stateField.text = "state"
        
    }
    
    private func configureTextFields(){
        self.showTableViewHeight.constant = 35
        self.newAddressView.isHidden = true
        self.storeAddressView.isHidden = true
//        self.newAddressButton.isSelected = true
    }
    
    @IBAction func showStoredAddressButtonTapped() {
        
        if !self.storeAddressButton.isSelected {
            let count = PNUserManager.sharedInstance.addresses?.count ?? 0
            
            if( count == 0){
                  self.showTableViewHeight.constant = 35
            }else{
                 self.showTableViewHeight.constant = 280
            }
        self.storeAddressView.isHidden = false
        self.newAddressView.isHidden = true
       
        self.storeAddressButton.isSelected = true
        self.newAddressButton.isSelected = true

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
            self.storeAddressButton.isSelected = true
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
