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

class PNGuestLetsGetStartedWithNewFoodController: PNBaseViewController {
    
    @IBOutlet var letsGetStartedWithNewFoodView: PNGuestLetsGetStartedWithNewFoodView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dietryRestrictionsPressed(_ sender: Any) {
        
        let viewController = PNGuestLetsGetStartedWithDietaryRestrictionController(nibName: "PNGuestLetsGetStartedWithDietaryRestrictionController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
//        self.navigationController?.pushViewController(viewController, animated: true)
        AppDelegate.sharedInstance()?.moveToHome()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
