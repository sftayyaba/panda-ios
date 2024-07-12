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
 
    enum PNHomeTabs : Int{
        case home = 0
        case orders = 1
        case quickSearch = 2
        case Settings = 3
    }

    func moveToLogin(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNLoginViewController(nibName: "PNLoginViewController", bundle: nil))
        
        window?.rootViewController = navigationController
    }

    func moveToSingUp(){
        let navigationController : UINavigationController = UINavigationController(rootViewController: PNSignUpViewController(nibName: "PNSignUpViewController", bundle: nil))
        
        window?.rootViewController = navigationController
    }

//    func moveToHome(){
//        let navigationController : UINavigationController = UINavigationController(rootViewController: PNHomeViewController(nibName: "PNHomeViewController", bundle: nil))
//        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
//        window?.rootViewController = navigationController
//    }
    
    func moveToLetGetStarted(){
        if let navigationController : UINavigationController = window?.rootViewController as? UINavigationController {
            let vc = PNGuestLetsGetStartedViewController(nibName: "PNGuestLetsGetStartedViewController", bundle: nil)
            navigationController.pushViewController(vc, animated: true)
            
        }
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

    func moveToHome(atTab: PNHomeTabs){
      
        let jobsViewController = PNHomeViewController(nibName:"PNHomeViewController", bundle: nil)
        let jobsNavController = UINavigationController(rootViewController: jobsViewController)
        jobsNavController.navigationBar.barTintColor = UIColor.customRedColor()
        
        jobsNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        jobsNavController.navigationItem.title = "Jobs"
        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let applicantionsViewController = PNOrdersViewController(nibName:"PNOrdersViewController", bundle:nil)
//        let applicantionsViewController = mainStoryboard.instantiateViewController(withIdentifier: "PNOrdersViewController") as! PNOrdersViewController
        let applicantionsNavController = UINavigationController(rootViewController: applicantionsViewController)
        applicantionsNavController.navigationBar.barTintColor = UIColor.customRedColor()
        
        applicantionsNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        applicantionsViewController.navigationItem.title = "Applications"
        //
        let organizationViewController = PNQuickSearchViewController(nibName:"PNQuickSearchViewController", bundle: nil)
        let organizationNavController = UINavigationController(rootViewController: organizationViewController)
        organizationNavController.navigationBar.barTintColor = UIColor.customRedColor()
        
        organizationNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        organizationViewController.navigationItem.title = "Organizations"
        
        
        let settingViewController = PNSettingViewController(nibName:"PNSettingViewController", bundle:nil)
        let settingsNavController = UINavigationController(rootViewController: settingViewController)
        settingsNavController.navigationBar.barTintColor = UIColor.customRedColor()
        
        settingsNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        settingViewController.navigationItem.title = "Settings"
        
//        NotificationNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        notificationViewController.navigationItem.title = "Notification"
        
        let viewControllers = [jobsNavController,applicantionsNavController , organizationNavController,settingsNavController]
        
        let vc = self.initialiseTabBarControllerWithViewController(viewControllers: viewControllers)
        
        UINavigationBar.appearance().tintColor = .white
        window?.rootViewController = vc
        vc.selectedIndex = atTab.rawValue
    }
    
    
    func initialiseTabBarControllerWithViewController(viewControllers: [UIViewController]) -> UITabBarController {
        let scheduleItem : UITabBarItem = UITabBarItem(title: "", image: UIImage(named:"home_icon_black"), tag: 0)
        scheduleItem.image = UIImage(named:"home_icon_black")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        scheduleItem.selectedImage = UIImage(named:"home_icon_black")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        scheduleItem.imageInsets = UIEdgeInsets(top: ApplicationNumberConstants.kTabBarItemImageTopPadding, left: 0, bottom: -1*ApplicationNumberConstants.kTabBarItemImageTopPadding, right: 0)
        
        viewControllers[scheduleItem.tag].tabBarItem = scheduleItem
        
        
        
        let applicantsItem : UITabBarItem = UITabBarItem(title: "", image: UIImage(named:"Orders icon"), tag: 1)
        applicantsItem.image = UIImage(named:"Orders icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        applicantsItem.selectedImage = UIImage(named:"Orders icon red")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        applicantsItem.imageInsets = UIEdgeInsets(top: ApplicationNumberConstants.kTabBarItemImageTopPadding, left: 0, bottom: -1*ApplicationNumberConstants.kTabBarItemImageTopPadding, right: 0)
        
        viewControllers[applicantsItem.tag].tabBarItem = applicantsItem
        
        
        
        let partTimersItem : UITabBarItem = UITabBarItem(title: "", image: UIImage(named:"Inbox icon"), tag: 2)
        partTimersItem.image = UIImage(named:"Inbox icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        partTimersItem.selectedImage = UIImage(named:"Restaurants icon red ")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        partTimersItem.imageInsets = UIEdgeInsets(top: ApplicationNumberConstants.kTabBarItemImageTopPadding, left: 0, bottom: -1*ApplicationNumberConstants.kTabBarItemImageTopPadding, right: 0)
        
        viewControllers[partTimersItem.tag].tabBarItem = partTimersItem
        
        
//        let notifcationItem : UITabBarItem = UITabBarItem(title: "", image: UIImage(named:"Notifications"), tag: 3)
//        notifcationItem.image = UIImage(named:"Notifications")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        notifcationItem.selectedImage = UIImage(named:"notifications-active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//
//        notifcationItem.imageInsets = UIEdgeInsets(top: ApplicationNumberConstants.kTabBarItemImageTopPadding, left: 0, bottom: -1*ApplicationNumberConstants.kTabBarItemImageTopPadding, right: 0)
//
//        viewControllers[notifcationItem.tag].tabBarItem = notifcationItem
        
        let settingsItem : UITabBarItem = UITabBarItem(title: "", image: UIImage(named:"Settings icon"), tag: 3)
        settingsItem.image = UIImage(named:"Settings icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        settingsItem.selectedImage = UIImage(named:"Settings icon red")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        settingsItem.imageInsets = UIEdgeInsets(top: ApplicationNumberConstants.kTabBarItemImageTopPadding, left: 0, bottom: -1*ApplicationNumberConstants.kTabBarItemImageTopPadding, right: 0)
        
        viewControllers[settingsItem.tag].tabBarItem = settingsItem
        
        let tabController = UITabBarController()
        
//        tabController.tabBar.selectionIndicatorImage = UIImage.selectedTabBackgroundImage(width: (window?.frame.size.width)!/4.0, height: 49)
        
        tabController.viewControllers = viewControllers
        tabController.tabBar.tintColor = UIColor.customRedColor()
        return tabController
    }
}
