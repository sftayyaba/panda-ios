//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNBudgetViewController: PNBaseViewController, UITextFieldDelegate {
    
    @IBOutlet var budgetView: PNBudgetView!
    
    @IBOutlet var budgetTableView: PNBudgetTableViewDelegateDatasource!

    var monthArray = [String]()
    var selectedMonthIndex: Int?
    var yearArray = [String]()
    var cardsArray = [PNCards]()
    var isNewCardAdded = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        isNewCardAdded = false
        self.configureTableView()
        self.configureNavigationBar()
        self.handleYearEvent()
        self.handleMonthEvent()
    }
    
    override func configureNavigationBar() {

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
            
//            if let errorMsg = response.message?.first?.localizedDescription{
//                self.alert(title: "Oops", message: errorMsg)
//            }else{
                //self.locationView.showStoredAddressButtonTapped()
            
            self.cardsArray = response.cards!
            
            if let selectedCard = PNUserManager.sharedInstance.selectedCard{
                self.budgetView.selectedCardLabel.text = PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!
            }
                self.budgetTableView.cardsArray = self.cardsArray
                self.budgetTableView.reloadData()
            
            if self.isNewCardAdded {
                self.navigationController?.popViewController(animated: true)
            }
                
//                self.alert(title: "Success", message: "Address added to your account")
        //    }

        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }

        })
    }
    
    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "PNBankOfAmericaTableViewCell", bundle: nil)
        self.budgetTableView.register(cellNib, forCellReuseIdentifier: "PNBankOfAmericaTableViewCell")
        
        let homeLocationNib = UINib(nibName: "PNBankOfWestTableViewCell", bundle: nil)
        self.budgetTableView.register(homeLocationNib, forCellReuseIdentifier: "PNBankOfWestTableViewCell")

        let momLocationNib = UINib(nibName: "PNChaseCardTableViewCell", bundle: nil)
        self.budgetTableView.register(momLocationNib, forCellReuseIdentifier: "PNChaseCardTableViewCell")
        
        
        self.budgetTableView.cardsArray = self.cardsArray
        
        self.budgetTableView.dataSource = self.budgetTableView
        self.budgetTableView.delegate = self.budgetTableView
        self.budgetTableView.reloadData()
    }

    override func configureCallBacks() {
        self.budgetTableView.didSelectCardCallback = {
            card in
            PNUserManager.sharedInstance.selectedCard = card
            self.budgetView.selectedCardLabel.text = card.nick != nil ? card.nick : card.type! + card.lastFour!
        }
        
        
        
        self.budgetTableView.didSelectRemoveCardCallback = {
            card in
            PNUserManager.sharedInstance.removeCard(CCId: card.ccId!, successBlock: { (locationResponse) in
                
                self.doInitialDataLoad()
                
            }, failureBlock: { (error) in
                
                PNUserManager.sharedInstance.selectedCard = nil
                self.budgetView.selectedCardLabel.text = "Chase card"
                self.doInitialDataLoad()
                
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Success", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
            })
        }
        
        self.budgetTableView.didSelectSetAsDefaultCardCallback = {
            card in
            PNUserManager.sharedInstance.addDefaults(CardId: card.ccId! , AddressId: nil, SuccessBlock: { (locationResponse) in
                
                self.doInitialDataLoad()
                
            }, FailureBlock: { (error) in
                
                PNUserManager.sharedInstance.selectedCard = card
                self.budgetView.selectedCardLabel.text = card.nick != nil ? card.nick : card.type! + card.lastFour!
                self.doInitialDataLoad()
                
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "!!!", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
            })
        }
        
        
        self.budgetTableView.didSelectEditCardCallback = {
            card in
        }
    }
    
    
    
    @IBAction func searchBarTapped(_ sender: UIButton) {
        self.alert(title: "!!!", message: "Coming Soon!")
    }
    
    
    @IBAction func addNewAddressButtonTapped(_ sender: Any) {
    
        if self.budgetView.nickNameTextField.text == "" {
            self.alert(title: "Alert", message: "Nick name field is empty!")
        }else if self.budgetView.zipCodeTextField.text == "" {
            self.alert(title: "Alert", message: "Zip field is empty!")
        }else if self.budgetView.cardNumberTextField.text == "" {
            self.alert(title: "Alert", message: "Card number field is empty!")
            
        }else if self.budgetView.cvvTextField.text == "" {
            self.alert(title: "Alert", message: "CVV field is empty!")
            
        }else if self.budgetView.expiryMonthTextField.text == "" {
            self.alert(title: "Alert", message: "Month field is empty!")
            
        }else if self.budgetView.expiryYearTextField.text == "" {
            self.alert(title: "Alert", message: "Year field is empty!")
            
        }else if self.budgetView.zipCodeTextField.text?.count != 5 {
            self.alert(title: "Alert", message: "ZIP code should be of 5 digits!")
        }
        else if (self.budgetView.cardNumberTextField.text?.count)! < 15 || (self.budgetView.cardNumberTextField.text?.count)! > 16 {
            self.alert(title: "Alert", message: "Credit Card number is invalid!")
        }
        else if (self.budgetView.cvvTextField.text?.count)! > 4 || (self.budgetView.cvvTextField.text?.count)! < 3   {
            self.alert(title: "Alert", message: "CVV should be of 3 or 4 digits!")
            
        }else {
            let nick = self.budgetView.nickNameTextField.text == "" ? nil : self.budgetView.nickNameTextField.text;
            let cardText = self.budgetView.cardNumberTextField.text!.replacingOccurrences(of: "-", with: "")

            PNUserManager.sharedInstance.addCreditCard(CardNumber: cardText, Zip: self.budgetView.zipCodeTextField.text!, Year: self.budgetView.expiryYearTextField.text!, ClientId: "ZmYxNjAxZjdmMDVhZWFkYTFkMDE3OTRmYmEzMDc1ZmIy", Cvv: self.budgetView.cvvTextField.text!, Month: self.budgetView.expiryMonthTextField.text!, NickName: nick,  successBlock: { (paymentResponse) in
                if let errorMsg = paymentResponse.message?.first?.localizedDescription{
                    self.alert(title: "Oops", message: errorMsg)
                }else{
                    //self.locationView.showStoredAddressButtonTapped()

                    self.isNewCardAdded = true
                    self.doInitialDataLoad()
                    
//                    self.budgetView.storeAddressView.isHidden = false
//                    self.budgetView.newAddressView.isHidden = true
//                    self.budgetView.showTableViewHeight.constant = 200
//                    self.budgetView.storeAddressButton.isSelected = true
//                    self.budgetView.arrowImageView.image = UIImage(named: "Arrow - Big - Up - Black")

//                    self.alert(title: "Success", message: "Successfully added your card.")
                }
            }, failureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
            })
            

        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.textColor = UIColor.white
        
        if textField.text?.characters.count == 4 && string.characters.count != 0 {
            textField.text = textField.text! + "-"
        }
        else if textField.text?.characters.count == 6 && string.characters.count == 0 {
            textField.text = String(textField.text!.characters.dropLast())
        }
        else if textField.text?.characters.count == 9 && string.characters.count != 0 {
            textField.text = textField.text! + "-"
        }
        else if textField.text?.characters.count == 11 && string.characters.count == 0{
            textField.text = String(textField.text!.characters.dropLast())
        }
        else if textField.text?.characters.count == 14 && string.characters.count != 0 {
            textField.text = textField.text! + "-"
        }
        else if textField.text?.characters.count == 16 && string.characters.count == 0 {
            textField.text = String(textField.text!.characters.dropLast())
        }
        if textField.text?.characters.count == 19 && string.characters.count != 0 {
            return false
        }
        return true
    }
    
    //MARK: Events
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
        
//        self.budgetView.expiryMonthTextField.pickerType = .StringPicker
//        self.budgetView.expiryMonthTextField.stringPickerData =  self.monthArray
//        self.budgetView.expiryMonthTextField.toolbar.tintColor = UIColor.navigationColor()
//
//        self.budgetView.expiryMonthTextField.stringDidChange = { index in
//            self.budgetView.expiryMonthTextField.text = self.monthArray[index]
//            self.selectedMonthIndex = index
//        }
    }
    
    private func handleYearEvent() {
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)

        for i in 0..<20 {
            self.yearArray.append("\(year + i)")
        }

//        self.budgetView.expiryYearTextField.pickerType = .StringPicker
//        self.budgetView.expiryYearTextField.stringPickerData =  self.yearArray
//        self.budgetView.expiryYearTextField.toolbar.tintColor = UIColor.navigationColor()
//
//        self.budgetView.expiryYearTextField.stringDidChange = { index in
//            self.budgetView.expiryYearTextField.text =  self.yearArray[index]
//        }
    }
 
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
