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

class PNPlaceOrderViewController: PNBaseViewController {
    
    @IBOutlet var placeOrderView: PNPlaceOrderView!
      
    @IBOutlet var tableView: PNPlaceOrderDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        self.configureTableView()
    }
    override func configureCallBacks() {
        
        self.tableView.didAddItemButtonCallback={
            let viewController = PNPlaceOrderAddItemRootViewController(nibName: "PNPlaceOrderAddItemRootViewController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    

    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "PNPlaceOrderLocationHeaderViewTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "PNPlaceOrderLocationHeaderViewTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderImageSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderImageSliderTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderItemsTableViewCell")

        self.tableView.register(UINib(nibName: "PNPlaceOrderLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderLocationTableViewCell")

        self.tableView.register(UINib(nibName: "PNPlaceOrderPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderPaymentTableViewCell")

        
        //MARK: Location Cells
        self.tableView.register(UINib(nibName: "PNPlaceOrderCurrentLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderCurrentLocationTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNAddLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNAddLocationTableViewCell")

        

        self.tableView.dataSource = self.tableView
        self.tableView.delegate = self.tableView
        self.tableView.reloadData()
    }
    
    @IBAction func placeOrderPressed(_ sender: UIButton) {
        let viewController = PNPlaceOrderSuccessViewController(nibName: "PNPlaceOrderSuccessViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
