//
//  JNBaseViewController.swift
//  JobsNow
//
//  Created by Onebyte on 10/25/17.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import UIKit

class PNBaseViewController : UIViewController{
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
    
    
}
