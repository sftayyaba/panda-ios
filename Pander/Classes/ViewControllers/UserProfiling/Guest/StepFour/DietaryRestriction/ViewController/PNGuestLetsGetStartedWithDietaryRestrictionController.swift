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
    
    
    
    
    
    @IBAction func vegetarianClicked(_ sender: UIButton) {
        PNUserManager.sharedInstance.isVegetarian = !PNUserManager.sharedInstance.isVegetarian
    }
    @IBAction func veganClicked(_ sender: UIButton) {
        PNUserManager.sharedInstance.isVegan = !PNUserManager.sharedInstance.isVegan
    }
    @IBAction func noPeanutClicked(_ sender: UIButton) {
        PNUserManager.sharedInstance.isNoPeanut = !PNUserManager.sharedInstance.isNoPeanut
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        let message = "This feature is in testing, so it may not always be perfect. (For example - perhaps a 'vegetarian' soup may be made with fish stock without any way to know). If you're worried or have a health concern, please check directly with the restaurant before eating."
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func glutenFreeClicked(_ sender: UIButton) {
        PNUserManager.sharedInstance.isGlutenFree = !PNUserManager.sharedInstance.isGlutenFree
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
//        let viewController = PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil)
//        self.navigationController?.pushViewController(viewController, animated: true)
        PNUserManager.sharedInstance.updateTastePreferencesWith(SuccessBlock: { (response) in
            AppDelegate.sharedInstance()?.moveToHome()
        }) { (error) in
            
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
