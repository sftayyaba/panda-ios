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

class PNPlaceOrderSuccessViewController: PNBaseViewController {
    
    @IBOutlet var placeOrderSuccessView: PNPlaceOrderSuccessView!
      

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
