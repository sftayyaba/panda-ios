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
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        updateTotalPrice()
    }
    
    func updateTotalPrice(){
        if let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
            return result + dish.price!
        }){
            self.placeOrderView.totalPriceLabel.text = totalPrice.format(f: "")
            
        }
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
    
    @IBAction func getNewSuggestionsTapped(_ sender: Any) {
        var searchAddress = ""
        var city = ""
        var zip = ""
        var addressId = ""
        let category = 2
        var cuisine = ""
        let groupSize = PNUserManager.sharedInstance.groupSize
        let budgetPerPerson = PNUserManager.sharedInstance.budgetPerPerson
        let orderMode = 0
        let restsTried = "[" +  PNOrderManager.sharedInstance.prevRestaurentIds.joined(separator: ",") + "]"
        
        if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
            searchAddress = "\(selectedAddress.street!),\(selectedAddress.zipCode!)"
            city = selectedAddress.city!
            zip = selectedAddress.zipCode!
            addressId = "\(selectedAddress.locationId!)"
        }else{
            self.alert(title: "Oops", message: "No Delivery address is selected.")
            return
        }
        
        if let selectedCuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
            cuisine = selectedCuisines.joined(separator: ",")
        }else{
            self.alert(title: "Oops", message: "No Cuisine is selected.")
            return
        }
        
        PNOrderManager.sharedInstance.generateOrder(SearchAddress: searchAddress, AddressCity: city, AddressZip: zip, AddressId: addressId, Catergory: category, Cuisine: cuisine, GroupSize: groupSize, BudgetPerPerson: budgetPerPerson, OrderMode: orderMode, RestsTried: restsTried, SuccessBlock: { (generatedOrderResponse) in
            
            PNOrderManager.sharedInstance.getGeneratedOrder(TaskId: generatedOrderResponse.id!, SuccessBlock: { (orderReponse) in
                
                
                self.tableView.reloadData()
                self.updateTotalPrice()
                
            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
            })
            
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        }
        
    }
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f).02f", self)
    }
}
