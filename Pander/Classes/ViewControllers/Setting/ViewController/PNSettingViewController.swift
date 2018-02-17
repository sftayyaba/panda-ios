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

class PNSettingViewController: PNBaseViewController {
    
    @IBOutlet var settingView: PNSettingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationBar() {
        //        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
