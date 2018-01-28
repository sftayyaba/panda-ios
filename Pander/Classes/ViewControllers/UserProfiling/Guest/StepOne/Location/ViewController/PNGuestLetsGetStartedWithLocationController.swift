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

class PNGuestLetsGetStartedWithLocationController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithLocationView: PNGuestLetsGetStartedWithLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.guestLetsGetStartedWithLocationView.setNextButtonState()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {

        if let zip = self.guestLetsGetStartedWithLocationView.zipCodeTextField.text{
            PNUserManager.sharedInstance.checkAddressIsSupported(Zip: zip, SuccessBlock: {
                successResponse in

                self.moveToNext()
                
            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
                
            })
            
        }
        
    }
    
    
    
    func moveToNext(){
        if PNUserManager.sharedInstance.user != nil || PNUserManager.sharedInstance.guestUser != nil{
            let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
        self.navigationController?.popViewController(animated:true)
    }
}
