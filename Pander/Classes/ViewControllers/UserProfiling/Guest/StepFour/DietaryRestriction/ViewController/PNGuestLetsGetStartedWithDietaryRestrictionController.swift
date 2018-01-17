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

class PNGuestLetsGetStartedWithDietaryRestrictionController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithDietryRestrictionView: PNGuestLetsGetStartedWithDietaryRestrictionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
//        self.navigationController?.pushViewController(viewController, animated: true)
        AppDelegate.sharedInstance()?.moveToHome()

    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
