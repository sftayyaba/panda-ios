//
//  AppDelegate.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKLoginKit
import GoogleSignIn
import GoogleToolboxForMac

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?
    var token = String()
    
    public var didPressCallAPIButtonCallback : ((_ tilte: String) -> Void)?

    class func sharedInstance ()-> AppDelegate?{
        let sharedInstance = {
            UIApplication.shared.delegate as? AppDelegate
        }()
        return sharedInstance;
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        if let window = window {
            
            window.tintColor = UIColor.red
            
            window.backgroundColor = UIColor.white
            
            self.moveToSingUp()
            
            window.makeKeyAndVisible()
        }

        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().clientID = "524861039894-lrgu4kjudamd75edoiqvlmm2edthkusj.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        IQKeyboardManager.sharedManager().enable = true
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            token = user.authentication.accessToken // Safe to send to the server
            //print(token)
            if didPressCallAPIButtonCallback != nil {
                didPressCallAPIButtonCallback!(token)
            }
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let image = user.profile.imageURL(withDimension: 100)
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        FBSDKAppEvents.activateApp()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
//    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,  sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

        return googleDidHandle || facebookDidHandle
    }
    

}

