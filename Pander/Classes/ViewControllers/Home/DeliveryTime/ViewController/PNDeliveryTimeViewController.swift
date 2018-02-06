//
//  PNLoginViewController.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNDeliveryTimeViewController: PNBaseViewController {
    
    @IBOutlet var deliveryView: PNDeliveryView!
    
//    @IBOutlet var deliveryTimeTableView: PNDeliveryTimeTableViewDelegateDatasource!
    @IBOutlet var deliveryDateTableView: PNDeliveryDateTableViewDelegateDatasource!

     var dateArray = [String]()
     var dateState = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureNavigationBar()
    }
    
    override func configureNavigationBar() {
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.edgesForExtendedLayout = []
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    fileprivate func configureTableView() {
        
        let nib = UINib(nibName: "PNDeliveryDateTableViewCell", bundle: nil)
        self.deliveryDateTableView.register(nib, forCellReuseIdentifier: "PNDeliveryDateTableViewCell")
        
        self.deliveryDateTableView.dateArray = self.configureArray()
        self.deliveryDateTableView.dateState = self.dateState
        self.deliveryDateTableView.dataSource = self.deliveryDateTableView
        self.deliveryDateTableView.delegate = self.deliveryDateTableView
        self.deliveryDateTableView.reloadData()
    }

    func configureArray()-> [String] {
        for i in 0..<7{
            self.dateState.append(false)
            if i == 0{
                self.dateArray.append("Today")
            }else if i == 1 {
                self.dateArray.append("Tomorrow")
            }else {
                self.dateArray.append(Calendar.current.date(byAdding: .day, value: i, to: Date())!.weekdayNameFull)
            }
        }

        return self.dateArray
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        PNUserManager.sharedInstance.logoutUser()
        AppDelegate.sharedInstance()?.moveToSingUp()
    }
}
