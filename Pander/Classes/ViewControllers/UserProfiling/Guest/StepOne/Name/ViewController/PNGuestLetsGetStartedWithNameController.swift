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

class PNGuestLetsGetStartedWithNameController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedWithNameView: PNGuestLetsGetStartedWithNameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let viewController = PNGuestLetsGetStartedViewController(nibName: "PNGuestLetsGetStartedViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
