//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire
import FacebookLogin
import FacebookCore
import GoogleSignIn

class PNForgotPasswordViewController: PNBaseViewController {
    
    @IBOutlet var forgotPasswordView: PNForgotPasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func configureNavigationBar() {
        
    }
    
    override func configureView() {
        
    }
    
    fileprivate func configureFacebookLoginButton() {
        
    }
    
    func getFBUserData(){
        
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if let email = self.forgotPasswordView.emailTextField.text {
            if email.isEmail {
            PNUserManager.sharedInstance.changePasswordWith(Email: email, successBlock: {
                self.navigationController?.popViewController(animated: true)
            }, failureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Opss", message: localError.devMsg!)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
            })
            }else{
                self.alert(title: "Error", message: "Enter Valid Email")
            }
        }else{
            self.alert(title: "Error", message: "Email is required")
        }
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
}
