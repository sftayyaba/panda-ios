//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNLocationViewController: PNBaseViewController {
    
    @IBOutlet var locationView: PNLocationView!
    
    @IBOutlet var locationTableView: PNLocationTableViewDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureNavigationBar()
    }
    
    override func configureNavigationBar() {
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

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
    }
    
    @IBAction func searchBarTapped(_ sender: UIButton) {
        self.alert(title: "!!!", message: "Coming Soon!")
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
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
                            if unit_number.count >= 2{
                                
                                if let state = self.locationView.stateField.text {
                                    if state.count >= 2{
                                        
                                        if let zip = self.locationView.zipCodeField.text {
                                            if zip.count >= 5{
                                                
                                                if let phone = self.locationView.phoneNumberField.text {
                                                    if phone.count >= 10 && phone.count <= 12{
                                                        
                                                        PNUserManager.sharedInstance.addLocation(Street: streetAddress, Zip: zip, City: city, State: state, Phone: phone, UnitNumber: unit_number, NickName: self.locationView.addressNickNameField.text, successBlock: {
                                                            locationResponse in
                                                            
                                                            if let errorMsg = locationResponse.message?.first?.localizedDescription{
                                                                self.alert(title: "Oops", message: errorMsg)
                                                            }else{
                                                                self.locationView.showStoredAddressButtonTapped()

                                                                self.alert(title: "Success", message: "Address added to your account")
                                                            }
                                                            
                                                            
                                                        }, failureBlock: { (error) in
                                                            if let localError = error as? ErrorBaseClass{
                                                                self.alert(title: "Oops", message: localError.localizedDescription)
                                                            }else {
                                                                self.alert(title: "Error", message: "Something went wrong !")
                                                            }
                                                        })
                                                        
                                                    }else{
                                                        self.alert(title: "Oops", message: "Phone number must be atleast 5 letter.");
                                                    }
                                                }else{
                                                    self.alert(title: "Oops", message: "Phone number is required");
                                                }
                                                
                                                
                                            }else{
                                                self.alert(title: "Oops", message: "ZipCode must be atleast 5 letter.");
                                            }
                                        }else{
                                            self.alert(title: "Oops", message: "ZipCode is required");
                                        }

                                        
                                    }else{
                                        self.alert(title: "Oops", message: "State must be atleast 2 letter.");
                                    }
                                }else{
                                    self.alert(title: "Oops", message: "State is required");
                                }

                                
                            }else{
                                self.alert(title: "Oops", message: "Unit/Apt/Suite must be atleast 2 letter.");
                            }
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
                self.alert(title: "Oops", message: "Street Address must be atleast 5 letter.");
            }
        }else{
            self.alert(title: "Oops", message: "Street Address is required");
        }
    }
}
