//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import Alamofire

class PNGuestLetsGetStartedViewController: PNBaseViewController {
    
    @IBOutlet var guestLetsGetStartedView: PNGuestLetsGetStartedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func letGetStartedButtonTapped(_ sender: Any) {
    
//        let locationViewController = PNGuestLetsGetStartedStepThreeController(nibName: "PNGuestLetsGetStartedStepThreeController", bundle: nil)
//        self.navigationController?.pushViewController(locationViewController, animated: true)
//
        let locationViewController = PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil)
        self.navigationController?.pushViewController(locationViewController, animated: true)
        
    }
    
    @IBAction func backtoLoginButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
