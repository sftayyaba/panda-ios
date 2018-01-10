//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire
import OnebyteSwiftNetworkCycle
import FacebookLogin
import GoogleSignIn

class PNSignUpViewController: PNBaseViewController,GIDSignInUIDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self

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
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func configureNavigationBar() {
        
    }
    
    override func configureView() {
        
    }
    
    fileprivate func configureFacebookLoginButton() {
       
    }
    
    func getFBUserData(){
       
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        
//        let loginOperation:PNSignUpOperation = PNSignUpOperation()
        
//        loginOperation.email = "sheraz.ipa1@gmail.com"
//        loginOperation.password = "sjdnej"
//        loginOperation.firstName = "sheraz"
//        loginOperation.lastName = "Rasheed"
//
//        loginOperation.didFinishSuccessfullyCallback = { response in
//        
//        }
//        
//        loginOperation.didFinishWithErrorCallback = { error in
//            
//        }
//        
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(loginOperation)
        
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
    
        let fbManager = LoginManager()
        
        fbManager.logIn(publishPermissions: [.publishActions], viewController: self) {
            result in
            
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, _, let userInfo):
                print(userInfo.authenticationToken)
            }
        }
    }
    
    //MARK: Gmail Login
    @IBAction func gmailButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
        (UIApplication.shared.delegate as! AppDelegate).didPressCallAPIButtonCallback = { token in
            print(token)
        }
    }
    
    @IBAction func continueAsGuestButtonTapped(_ sender: Any) {
        AppDelegate.sharedInstance()?.moveToLetGetStarted()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        AppDelegate.sharedInstance()?.moveToLogin()
    }

}
