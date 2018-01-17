//
//  AppNavigation.swift
//  JobsNow
//
//  Created by Onebyte on 10/23/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{
 
    func moveToLogin(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNLoginViewController(nibName: "PNLoginViewController", bundle: nil))
        
        window?.rootViewController = navigationController
    }

    func moveToSingUp(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNSignUpViewController(nibName: "PNSignUpViewController", bundle: nil))
        
        window?.rootViewController = navigationController
    }

    func moveToHome(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNHomeViewController(nibName: "PNHomeViewController", bundle: nil))
        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
    
    func moveToLetGetStarted(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNGuestLetsGetStartedViewController(nibName: "PNGuestLetsGetStartedViewController", bundle: nil))
        window?.rootViewController = navigationController
    }
    
    func moveToLetGetStartedWithLocation(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNGuestLetsGetStartedWithLocationController(nibName: "PNGuestLetsGetStartedWithLocationController", bundle: nil))
        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
    
    func moveToLetGetStartedWithName(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNGuestLetsGetStartedWithNameController(nibName: "PNGuestLetsGetStartedWithNameController", bundle: nil))
        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
    
    func moveToLetGetStartedWithEmail(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNGuestLetsGetStartedWithEmailController(nibName: "PNGuestLetsGetStartedWithEmailController", bundle: nil))
        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
    
    func moveToCuisineSelection(){
        let viewController = PNGuestLetsGetStartedStepTwoController(nibName: "PNGuestLetsGetStartedStepTwoController", bundle: nil)
        if let navigationController = window?.rootViewController as? UINavigationController
        {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    
    func moveToDishSelection(){
        let viewController = PNGuestLetsGetStartedStepThreeController(nibName: "PNGuestLetsGetStartedStepThreeController", bundle: nil)
        if let navigationController = window?.rootViewController as? UINavigationController
        {
            navigationController.pushViewController(viewController, animated: true)
        }
    }

}
