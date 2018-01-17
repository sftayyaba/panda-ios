//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire
import FacebookLogin
import GoogleSignIn

class PNHomeViewController: PNBaseViewController {
    
    @IBOutlet var homeView: PNHomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
