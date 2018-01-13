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

class PNGuestLetsGetStartedWithNameController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithNameView: PNGuestLetsGetStartedWithNameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        
        if let completeName = self.guestLetsGetStartedWithNameView.nameTextField.text{
            if completeName.trimmingCharacters(in: .whitespaces).split(separator:" ").count >= 2 {
            
                PNUserManager.sharedInstance.selectedName = completeName.trimmingCharacters(in: .whitespaces)
                
                let viewController = PNGuestLetsGetStartedWithEmailController(nibName: "PNGuestLetsGetStartedWithEmailController", bundle: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                self.alert(title: "Alert", message: "Please add full name")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
}
