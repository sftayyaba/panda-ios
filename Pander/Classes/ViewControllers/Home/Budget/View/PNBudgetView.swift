//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import TextFieldEffects
import AAPickerView

class PNBudgetView: UIView,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var expireMonthPickerView : UIPickerView!
    var expireYearPickerView : UIPickerView!
    var monthArray = [String]()
    var yearArray = [String]()
    
    @IBOutlet weak var selectedCardLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet weak var labelTapToAdd: UILabel!

    @IBOutlet weak var budgetPerPersonLabel: UILabel!
    @IBOutlet weak var paywith :UILabel!
    @IBOutlet weak var budgetPerPersonSlider: UISlider!
    @IBOutlet var cardNumberTextField:UITextField!

    @IBOutlet var expiryMonthTextField: UITextField!
    @IBOutlet var expiryYearTextField: UITextField!
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
            if(PNUserManager.sharedInstance.cardsBaseObject?.cards?.count == 0){
                 self.showTableViewHeight.constant = 35
            }else{
                 self.showTableViewHeight.constant = 200
            }
        self.storeAddressView.isHidden = false
        self.newAddressView.isHidden = true
       
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
            self.storeAddressView.isHidden = true
            self.showTableViewHeight.constant = 35
            self.newAddressButton.isSelected = false
            self.newAddressView.isHidden = false
            self.arrowImageView.image = UIImage(named: "Arrow - Big - down - Black")
            self.labelTapToAdd.text = "HIDE"
            
            handleMonthEvent()
            expireMonthPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.frame.size.width, height: 216))
            expireMonthPickerView.delegate = self
            expireMonthPickerView.dataSource = self
            expireMonthPickerView.backgroundColor = UIColor.white
            expiryMonthTextField.inputView = expireMonthPickerView
            
            
            handleYearEvent()
            expireYearPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.frame.size.width, height: 216))
            expireYearPickerView.delegate = self
            expireYearPickerView.dataSource = self
            expireYearPickerView.backgroundColor = UIColor.white
            expiryYearTextField.inputView = expireYearPickerView
      
        }
    }
    
    
    private func handleMonthEvent() {
        
        let date = Date()
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
        
        for i in month..<12 {
            
            if i <= 9 {
                self.monthArray.append("0\(i)")
            }else {
                self.monthArray.append("\(i)")
            }
        }
    }
    
    
    private func handleYearEvent() {
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
        for i in 0..<20 {
            self.yearArray.append("\(year + i)")
        }
    }
    
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == expireMonthPickerView {
            return self.monthArray.count
        }else {
           return self.yearArray.count
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == expireMonthPickerView {
           return self.monthArray[row]
        }else {
           return self.yearArray[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == expireMonthPickerView {
           self.expiryMonthTextField.text = self.monthArray[row]
        }else {
            self.expiryYearTextField.text = self.yearArray[row]
        }
        
    }

}
