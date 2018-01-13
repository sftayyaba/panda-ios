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
        AppDelegate.sharedInstance()?.moveToLetGetStarted()

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

            AppDelegate.sharedInstance()?.moveToLetGetStarted()

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
            AppDelegate.sharedInstance()?.moveToLetGetStarted()

        }
    }
    
    @IBAction func continueAsGuestButtonTapped(_ sender: Any) {
        
        PNUserManager.sharedInstance.loginGuestUser(successBlock: {
        
            AppDelegate.sharedInstance()?.moveToLetGetStarted()

        }) { (error) in
            self.alert(title: "Error", message: error != nil ? error!.localizedDescription : "Something went wrong")
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        AppDelegate.sharedInstance()?.moveToLogin()
    }

}
