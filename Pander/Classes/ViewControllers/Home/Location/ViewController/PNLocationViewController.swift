//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit


enum PNFormMode{
    case edit
    case add
}

class PNLocationViewController: PNBaseViewController {

    //MARK: Instance Variables
    var addresses: [PNAddresses]?
    
    var currentEditAddress: PNAddresses?
    
    var currentMode: PNFormMode = .add
    
    var isNewAddressAdded = Bool()
    
    var locationId: Int?
    
    //MARK: Properties
    @IBOutlet var locationView: PNLocationView!
    
    @IBOutlet var locationTableView: PNLocationTableViewDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        isNewAddressAdded = false
        self.configureTableView()
        self.configureNavigationBar()
    }
    
    
    
    override func doInitialDataLoad() {
        PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
            
            self.addresses = response.addresses

            if let addresses = response.addresses{
                self.locationTableView.addresses = addresses
                self.locationView.selectedAddressLabel.text = PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street
            }
            
            self.locationTableView.reloadData()
            if self.isNewAddressAdded {
                
                for address in self.addresses! {
                    if address.locationId == self.locationId {
                        PNUserManager.sharedInstance.selectedAddress = address
                        self.locationView.selectedAddressLabel.text = address.nick != nil ? address.nick : address.street
                    }
                }

                self.navigationController?.popViewController(animated: true)
            }
            
        }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
        })
    }

    
    override func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "PNCurrentLocationTableViewCell", bundle: nil)
        self.locationTableView.register(cellNib, forCellReuseIdentifier: "PNCurrentLocationTableViewCell")
        
        let homeLocationNib = UINib(nibName: "PNHomeLocationTableViewCell", bundle: nil)
        self.locationTableView.register(homeLocationNib, forCellReuseIdentifier: "PNHomeLocationTableViewCell")

        let momLocationNib = UINib(nibName: "PNMomLocationTableViewCell", bundle: nil)
        self.locationTableView.register(momLocationNib, forCellReuseIdentifier: "PNMomLocationTableViewCell")

        let friendLocationNib = UINib(nibName: "PNFriendLocationTableViewCell", bundle: nil)
        self.locationTableView.register(friendLocationNib, forCellReuseIdentifier: "PNFriendLocationTableViewCell")

        let travisFieldNib = UINib(nibName: "PNTravisFieldTableViewCell", bundle: nil)
        self.locationTableView.register(travisFieldNib, forCellReuseIdentifier: "PNTravisFieldTableViewCell")

        
        self.locationTableView.dataSource = self.locationTableView
        self.locationTableView.delegate = self.locationTableView
        self.locationTableView.reloadData()
    }

    override func configureCallBacks() {
        self.locationTableView.didSelectAddressCallback = {
            address in
            PNUserManager.sharedInstance.selectedAddress = address
            self.locationView.selectedAddressLabel.text = address.nick != nil ? address.nick : address.street 
        }
        
        self.locationTableView.didSelectRemoveAddressCallback = {
            address in
            PNUserManager.sharedInstance.removeLocation(LocationId: "\(address.locationId!)", successBlock: { (locationResponse) in
                
                self.doInitialDataLoad()
                
            }, failureBlock: { (error) in
                
                self.doInitialDataLoad()

                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Success", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message : "Something went wrong !")
                }
            })
        }
        
        self.locationTableView.didSelectSetAsDefaultAddressCallback = {
            address in
            PNUserManager.sharedInstance.addDefaults(CardId: nil , AddressId: "\(address.locationId!)", SuccessBlock: { (locationResponse) in
                PNUserManager.sharedInstance.selectedAddress = address
                self.locationView.selectedAddressLabel.text = address.nick != nil ? address.nick : address.street
                self.doInitialDataLoad()
                
            }, FailureBlock: { (error) in
                
                self.doInitialDataLoad()
                
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "!!!", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
            })
        }
        
        
        self.locationTableView.didSelectEditAddressCallback = {
            address in
            
            self.currentMode = .edit
            
            self.locationView.addressNickNameField.text = address.nick
            self.locationView.streetAddressField.text = address.street
            self.locationView.cityField.text = address.city
            self.locationView.unit_numberField.text = address.unitNumber
            self.locationView.zipCodeField.text = address.zipCode
            self.locationView.phoneNumberField.text = address.phone
            self.locationView.stateField.text = address.state
            
            self.locationView.addNewAddressButton.setTitle("Save", for: UIControlState.normal)
            
            self.currentEditAddress = address
            
            self.locationView.showNewAddressButtonTapped()
        }
    }
    

    
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAddressPressed(_ sender: Any) {
        
        if let streetAddress = self.locationView.streetAddressField.text {
            if streetAddress.count >= 5{
                
                if let city = self.locationView.cityField.text {
                    if city.count >= 2{

                        if let unit_number = self.locationView.unit_numberField.text {
//                            if unit_number.count >= 2{
                            
                                if let state = self.locationView.stateField.text {
                                    if state.count >= 2{
                                        
                                        if let zip = self.locationView.zipCodeField.text {
                                            if zip.count == 5{
                                                
                                                if let phone = self.locationView.phoneNumberField.text {
                                                    if phone.count >= 10 && phone.count <= 12{
                                                        if self.locationView.addressNickNameField.text == "" {
                                                            self.alert(title: "Alert", message: "Nick name field is empty!")
                                                        }else{
                                                        if currentMode == .add{
                                                            
                                                            PNUserManager.sharedInstance.addLocation(Street: streetAddress, Zip: zip, City: city, State: state, Phone: phone, UnitNumber: unit_number == "" ? nil : unit_number, NickName: self.locationView.addressNickNameField.text == "" ? nil : self.locationView.addressNickNameField.text , successBlock: {
                                                                locationResponse in
                                                                
                                                                if let errorMsg = locationResponse.message?.first?.localizedDescription{
                                                                    self.alert(title: "!!!", message: errorMsg)
                                                                }else{
                                                                    self.isNewAddressAdded = true
                                                                    
                                                                
                                                                    
                                                                    self.doInitialDataLoad()
                                                                    
                                                                    self.locationView.refreshForm()
                                                                    
                                                                    self.locationId =  locationResponse.location?.locationId
                                                                    
                                                                    self.locationView.showStoredAddressButtonTapped()
                                                                    self.locationView.showStoredAddressButtonTapped()

                                                                }
                                                                
                                                                
                                                            }, failureBlock: { (error) in
                                                                if let localError = error as? ErrorBaseClass{
                                                                    self.alert(title: "Oops", message: localError.localizedDescription)
                                                                }else {
                                                                    self.alert(title: "Error", message: "Something went wrong !")
                                                                }
                                                            })
                                                            
                                                        }else if currentMode == .edit{
                                                            
                                                            PNUserManager.sharedInstance.updateLocation(LocationId: "\(currentEditAddress!.locationId!)" ,Street: streetAddress, Zip: zip, City: city, State: state, Phone: phone, UnitNumber: unit_number == "" ? nil : unit_number, NickName: self.locationView.addressNickNameField.text == "" ? nil : self.locationView.addressNickNameField.text , successBlock: {
                                                                locationResponse in
                                                                
                                                                if let errorMsg = locationResponse.message?.first?.localizedDescription{
                                                                    
                                                                    self.alert(title: "!!!", message: errorMsg)
                                                                }else{
                                                                    
                                                                    self.doInitialDataLoad()
                                                                    
                                                                    self.locationView.refreshForm()
                                                                    
                                                                    self.currentMode = .add
                                                                    self.currentEditAddress = nil
                                                                    
                                                                    self.locationView.addNewAddressButton.setTitle("Add new address", for: UIControlState.normal)
                                                                    self.locationView.showStoredAddressButtonTapped()
                                                                    self.alert(title: "Success", message: "Address added to your account")
                                                                }
                                                                
                                                                
                                                            }, failureBlock: { (error) in
                                                                
                                                                self.locationView.refreshForm()
                                                                
                                                                self.currentMode = .add
                                                                self.currentEditAddress = nil
                                                                
                                                                self.locationView.addNewAddressButton.setTitle("Add new address", for: UIControlState.normal)
                                                                
                                                                if let localError = error as? ErrorBaseClass{
                                                                    self.alert(title: "Oops", message: localError.localizedDescription)
                                                                }else {
                                                                    self.alert(title: "Error", message: "Something went wrong !")
                                                                }
                                                            })

                                                        }
                                                            
                                                        }
                                                    }else{
                                                        self.alert(title: "Oops", message: "Phone number must be 10 digits.");
                                                    }
                                                }else{
                                                    self.alert(title: "Oops", message: "Phone number is required");
                                                }
                                                
                                                
                                            }else{
                                                self.alert(title: "Oops", message: "ZipCode must be 5 digits.");
                                            }
                                        }else{
                                            self.alert(title: "Oops", message: "ZipCode is required");
                                        }

                                        
                                    }else{
                                        self.alert(title: "Oops", message: "State must be at least 2 letters.");
                                    }
                                }else{
                                    self.alert(title: "Oops", message: "State is required");
                                }

                                
//                            }else{
//                                self.alert(title: "Oops", message: "Unit/Apt/Suite must be atleast 2 letter.");
//                            }
                        }else{
                            self.alert(title: "Oops", message: "Unit/Apt/Suite is required");
                        }

                        
                    }else{
                        self.alert(title: "Oops", message: "City must be atleast 2 letter.");
                    }
                }else{
                    self.alert(title: "Oops", message: "City is required");
                }

            }else{
                self.alert(title: "Oops", message: "Street Address must be at least 5 letters.");
            }
        }else{
            self.alert(title: "Oops", message: "Street Address is required");
        }
    }
}
