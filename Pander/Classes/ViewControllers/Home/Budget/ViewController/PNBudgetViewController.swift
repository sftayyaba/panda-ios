//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNBudgetViewController: PNBaseViewController {
    
    @IBOutlet var budgetView: PNBudgetView!
    
    @IBOutlet var budgetTableView: PNBudgetTableViewDelegateDatasource!

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
        let cellNib = UINib(nibName: "PNBankOfAmericaTableViewCell", bundle: nil)
        self.budgetTableView.register(cellNib, forCellReuseIdentifier: "PNBankOfAmericaTableViewCell")
        
        let homeLocationNib = UINib(nibName: "PNBankOfWestTableViewCell", bundle: nil)
        self.budgetTableView.register(homeLocationNib, forCellReuseIdentifier: "PNBankOfWestTableViewCell")

        let momLocationNib = UINib(nibName: "PNChaseCardTableViewCell", bundle: nil)
        self.budgetTableView.register(momLocationNib, forCellReuseIdentifier: "PNChaseCardTableViewCell")
        
        self.budgetTableView.dataSource = self.budgetTableView
        self.budgetTableView.delegate = self.budgetTableView
        self.budgetTableView.reloadData()
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
}
