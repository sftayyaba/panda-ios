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

class PNGuestLetsGetStartedWithLocationController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithLocationView: PNGuestLetsGetStartedWithLocationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedWithEmailController(nibName: "PNGuestLetsGetStartedWithEmailController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
