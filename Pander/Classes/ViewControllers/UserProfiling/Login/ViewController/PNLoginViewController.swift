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

class PNLoginViewController: PNBaseViewController,GIDSignInUIDelegate {
    
    @IBOutlet var loginView: PNLoginView!
    
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
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {

        if let email = self.loginView.emailTextField.text, let password =
            self.loginView.passwordTextField.text {

            if email.isEmail {
                if password.count >= 5{

                    PNUserManager.sharedInstance.signIn(Email: email, Password: password, SuccessBlock: { (successResponse) in

                        AppDelegate.sharedInstance()?.moveToHome(atTab: AppDelegate.PNHomeTabs.home)

                    }, FailureBlock: { (error) in
                        if let localError = error as? ErrorBaseClass{
                            self.alert(title: "Oops", message: localError.localizedDescription)
                        }else {
                            self.alert(title: "Error", message: "Something went wrong !")
                        }
                    })
                    
                }else{
                    self.alert(title: "Error", message: "Incorrect Password.")
                }
            }else{
                self.alert(title: "Error", message: "Enter Valid Email.")
            }

        }else{
            self.alert(title: "Error", message: "Email and password are required")
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
    
        let fbManager = LoginManager()
        
        fbManager.logIn(readPermissions: [.email], viewController: self) { (result) in
            
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, _, let userInfo):
                print(userInfo.authenticationToken)
                print(userInfo.authenticationToken)
                
                if grantedPermissions.contains("email") {
                    
                    GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], accessToken: AccessToken.current, httpMethod: GraphRequestHTTPMethod.GET, apiVersion: GraphAPIVersion.defaultVersion).start({ (response, result) in
                        print(result)
                        
                        switch result {
                        case .failed(let error):
                            self.alert(title: "Error", message: error.localizedDescription)
                            break
                        case .success(let graphResponse):
                            if let responseDictionary = graphResponse.dictionaryValue {
                                print(responseDictionary)
                                
                                if let email = responseDictionary["email"] as? String, let accessToken = AccessToken.current?.authenticationToken, let userId = userInfo.userId{
                                    
                                    self.doLoginWithServerUsingFBData(FBToken: accessToken, FBUserID: userId, Email: email)
                                    
                                }
                            }
                        }
                        
                    })
                    
                    
                }
            }
        }
    }
    
    //MARK: Social Login Handlers
    func doLoginWithServerUsingFBData(FBToken fb_token: String , FBUserID fb_user_id: String , Email email: String){
        
        PNUserManager.sharedInstance.loginFBUser(FBToken: fb_token, FBUserID: fb_user_id, Email: email, successBlock: {
            
            if let firstSignUp = PNUserManager.sharedInstance.user?.isFirstSignup{
                if firstSignUp{
                    AppDelegate.sharedInstance()?.moveToLetGetStarted()
                }else{
                    AppDelegate.sharedInstance()?.moveToHome(atTab: AppDelegate.PNHomeTabs.home)
                }
            }else{
                AppDelegate.sharedInstance()?.moveToLetGetStarted()
            }

        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Error", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
    }
    
    //MARK: Gmail Login
    @IBAction func gmailButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
        (UIApplication.shared.delegate as! AppDelegate).didPressCallAPIButtonCallback = { token in
            print(token)
            PNUserManager.sharedInstance.loginGoogleUser(GoogleToken: token,successBlock: {
                
                if let firstSignUp = PNUserManager.sharedInstance.user?.isFirstSignup{
                    if firstSignUp{
                        AppDelegate.sharedInstance()?.moveToLetGetStarted()
                    }else{
                        AppDelegate.sharedInstance()?.moveToHome(atTab: AppDelegate.PNHomeTabs.home)
                    }
                }else{
                    AppDelegate.sharedInstance()?.moveToLetGetStarted()
                }
                
                
            }) { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Error", message: localError.localizedDescription)
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
            }

        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        
       AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
