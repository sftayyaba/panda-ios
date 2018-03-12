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

enum PNMenuTab: Int{
    case  main = 0
    case  appetizer = 1
    case  dessert = 2
    case  drink = 3
    
}

class PNPlaceOrderAddItemMainViewController: PNBaseViewController {
    
    var type: PNMenuTab!
    
    @IBOutlet var placeOrderAddItemMainView: PNPlaceOrderAddItemMainView!
    
    @IBOutlet var placeOrderAddItemMainDelegateDatasource: PNPlaceOrderAddItemMainDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
    }
    
    func configureTableView() {
        self.placeOrderAddItemMainDelegateDatasource.delegate = self.placeOrderAddItemMainDelegateDatasource
        
        self.placeOrderAddItemMainDelegateDatasource.dataSource = self.placeOrderAddItemMainDelegateDatasource

        
        self.placeOrderAddItemMainDelegateDatasource.register(UINib(nibName: "PNMenuAddedDishTableViewCell", bundle: nil), forCellReuseIdentifier: "PNMenuAddedDishTableViewCell")

        self.placeOrderAddItemMainDelegateDatasource.register(UINib(nibName: "PNPlaceOrderMainAddItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderMainAddItemTableViewCell")
        
        self.placeOrderAddItemMainDelegateDatasource.type = self.type
        
        self.placeOrderAddItemMainDelegateDatasource.reloadData()

    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
