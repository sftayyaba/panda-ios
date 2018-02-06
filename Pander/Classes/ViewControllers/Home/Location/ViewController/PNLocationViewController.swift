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
//        if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text, let password =
//            self.guestLetsGetStartedWithEmailView.passwordTextField.text {
//            if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text {
//                if email.isEmail {
//                    
//                    
//                    PNUserManager.sharedInstance.signUp(Email: email, Password: password, SuccessBlock: { (successResponse) in
//                        
//                        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
//                        self.navigationController?.pushViewController(viewController, animated: true)
//                        
//                    }, FailureBlock: { (error) in
//                        if let localError = error as? ErrorBaseClass{
//                            self.alert(title: "Opss", message: localError.localizedDescription)
//                        }else {
//                            self.alert(title: "Error", message: "Something went wrong !")
//                        }
//                    })
//            
//                }else{
//                    self.alert(title: "Error", message: "Enter valid email.")
//
//                }
//            }else{
//                self.alert(title: "Error", message: "Email and password are required")
//            }
//            
//        }
    }    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
