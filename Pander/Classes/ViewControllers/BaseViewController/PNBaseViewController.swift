//
//  JNBaseViewController.swift
//  JobsNow
//
//  Created by Onebyte on 10/25/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class PNBaseViewController : UIViewController, NVActivityIndicatorViewable{
    static var indicatorCount = 0
    
    //MARK: ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureView()
        self.configureObjects()
        self.configureCallBacks()
        self.doInitialDataLoad()
        self.configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkRequestStarted(notification:)), name: Notification.Name(PNNotificationTypes.networkRequestStarted.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkRequestStopped(notification:)), name: Notification.Name(PNNotificationTypes.networkRequestStopped.rawValue), object: nil)
        
        self.doInitialDataLoad()
    }

    
    //MARK: Initial Load
    internal func doInitialDataLoad(){
        /**
         * Initial loading will be implemented by Child ViewController
         **/
    }

    
    
    
    //MARK: View Configuration
    internal func configureView(){
        /**
         * View Configurations will be implemented by Child ViewController
         **/
    }
    
    
    //MARK: CallBacks Configuration
    internal func configureCallBacks(){
        /**
         * CallBacks Configurations will be implemented by Child ViewController
         **/
    }
    
    //MARK: Objects Configuration
    internal func configureObjects(){
        /**
         * Objects Configurations will be implemented by Child ViewController
         **/
    }

    //MARK: Objects Configuration
    internal func configureNavigationBar(){
        /**
         * Objects Configurations will be implemented by Child ViewController
         **/
    }

    internal func alert(title: String, message: String) {
        let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    
    //MARK: Progress Indicator Methods
    internal func showLoader(){
        if PNBaseViewController.indicatorCount == 0{
            startAnimating()
            
        }
        
        PNBaseViewController.indicatorCount+=1
        
    }
    internal func hideLoader(){
        PNBaseViewController.indicatorCount -= 1
        if(PNBaseViewController.indicatorCount==0 || PNBaseViewController.indicatorCount < 0){
            PNBaseViewController.indicatorCount = 0
            stopAnimating()
        }
    }
    
    //MARK: Notification Observer Methods
    @objc private func networkRequestStarted(notification: Notification){
        self.showLoader()
    }
    @objc private func networkRequestStopped(notification: Notification){
        self.hideLoader()
    }
    
}
