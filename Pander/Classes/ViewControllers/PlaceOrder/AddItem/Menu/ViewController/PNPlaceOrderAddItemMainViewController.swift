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

class PNPlaceOrderAddItemMainViewController: PNBaseViewController {
    
    @IBOutlet var placeOrderAddItemMainView: PNPlaceOrderAddItemMainView!
    
    @IBOutlet var placeOrderAddItemMainDelegateDatasource: PNPlaceOrderAddItemMainDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
    }
    
    func configureTableView() {
        self.placeOrderAddItemMainDelegateDatasource.delegate = self.placeOrderAddItemMainDelegateDatasource
        
        self.placeOrderAddItemMainDelegateDatasource.dataSource = self.placeOrderAddItemMainDelegateDatasource

        self.placeOrderAddItemMainDelegateDatasource.register(UINib(nibName: "PNPlaceOrderMainAddItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderMainAddItemTableViewCell")
        
        self.placeOrderAddItemMainDelegateDatasource.reloadData()
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
