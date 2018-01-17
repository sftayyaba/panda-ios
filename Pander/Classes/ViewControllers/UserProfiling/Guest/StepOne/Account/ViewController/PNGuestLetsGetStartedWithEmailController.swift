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

class PNGuestLetsGetStartedWithEmailController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithEmailView: PNGuestLetsGetStartedWithEmailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        self.guestLetsGetStartedWithEmailView.mainTitleText.text = "Nice to meet you, \(PNUserManager.sharedInstance.selectedName!)! Let's setup your account"
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text, let password =
            self.guestLetsGetStartedWithEmailView.passwordTextField.text {
            if let email = self.guestLetsGetStartedWithEmailView.emailTextField.text {
                if email.isEmail {
                    
                    
                    PNUserManager.sharedInstance.signUp(Email: email, Password: password, SuccessBlock: { (successResponse) in
                        
                        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
                        self.navigationController?.pushViewController(viewController, animated: true)
                        
                    }, FailureBlock: { (error) in
                        if let localError = error as? ErrorBaseClass{
                            self.alert(title: "Opss", message: localError.localizedDescription)
                        }else {
                            self.alert(title: "Error", message: "Something went wrong !")
                        }
                    })
            
                }else{
                    self.alert(title: "Error", message: "Enter valid email.")

                }
            }else{
                self.alert(title: "Error", message: "Email and password are required")
            }
            
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
