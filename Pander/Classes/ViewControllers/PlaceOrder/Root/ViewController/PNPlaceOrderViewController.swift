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
import SwiftyJSON

class PNPlaceOrderViewController: PNBaseViewController {
    
    @IBOutlet var placeOrderView: PNPlaceOrderView!
      
    @IBOutlet var tableView: PNPlaceOrderDelegateDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(plusObserver), name: NSNotification.Name(rawValue: "plus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minusObserver), name: NSNotification.Name(rawValue: "minus"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        updateTotalPrice()
    }
    
    
    @objc func plusObserver(notification:NSNotification) {
        
        if let dish = notification.userInfo?["dish"] as? PNOrderDish {
            let unitPrice = dish.unitPrice
            
            if UserDefaults.standard.object(forKey: "myTotalPrice") != nil{
                var totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
                totalPrice = totalPrice + unitPrice!
                UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
                self.placeOrderView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
            }else {
                if var totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
                    return result + dish.price!
                }){
                    totalPrice = totalPrice + unitPrice!
                    self.placeOrderView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
                    UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
                }
            }
        }
    }
    
    @objc func minusObserver(notification:NSNotification) {
        
        if let dish = notification.userInfo?["dish"] as? PNOrderDish {
            let unitPrice = dish.unitPrice
            var totalPrice = UserDefaults.standard.object(forKey: "myTotalPrice") as! Float
            totalPrice = totalPrice - unitPrice!
            
            self.placeOrderView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
            UserDefaults.standard.set(totalPrice, forKey: "myTotalPrice")
            
        }
    }

    
    func updateTotalPrice(){
        if let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
            return result + dish.price!
        }){
           // self.placeOrderView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
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
        self.tableView.didPressShowAddressCallback = {
            let viewController = PNLocationViewController(nibName: "PNLocationViewController", bundle: nil)
            
            self.navigationController?.pushViewController(viewController, animated: true)

        }
        
        self.tableView.didPressShowCardCallback = {
            let viewController = PNBudgetVC(nibName: "PNBudgetVC", bundle: nil)
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        
        self.tableView.editAndReorderButtonCallback = {
            self.placeOrderPressed()
        }
        
        self.tableView.newSuggestionButtonCallback = {
            self.getNewSuggestionsTapped()
        }
        
    }
    

    fileprivate func configureTableView() {
        let cellNib = UINib(nibName: "PNPlaceOrderLocationHeaderViewTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "PNPlaceOrderLocationHeaderViewTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderImageSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderImageSliderTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderItemsTableViewCell")

        self.tableView.register(UINib(nibName: "PNPlaceOrderLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderLocationTableViewCell")

        self.tableView.register(UINib(nibName: "PNPlaceOrderPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderPaymentTableViewCell")

         self.tableView.register(UINib(nibName: "PNPlaceOrderTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderTotalTableViewCell")
        
        //MARK: Location Cells
        self.tableView.register(UINib(nibName: "PNPlaceOrderCurrentLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderCurrentLocationTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNAddLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNAddLocationTableViewCell")

        

        self.tableView.dataSource = self.tableView
        self.tableView.delegate = self.tableView
        self.tableView.reloadData()
    }
    
     func placeOrderPressed() {
        
        let order: [PNOrderDish] =  (PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order)!
        
//        let dictionaryArray = order.map { (order) -> [String: Any] in
//            return order.dictionaryRepresentation()
//        }
        
        
//      do {
//        let jsonData = try JSONSerialization.data(withJSONObject: dictionaryArray, options: JSONSerialization.WritingOptions.prettyPrinted)
//        if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
//            print(JSONString)
//        }
//
//      } catch {
//        }
        
        
        
        
        
        
        var dictionaryArray = order.map({$0.submission.map({$0.dictionaryRepresentation()})})
        
//        for dic in dictionaryArray {
//            var quantityOption = dic!["option_qty"] as! [String:Any]
//            let itemId = dic!["item_id"] as! String
//            let  itemQuantity = dic!["item_qty"] as! Int
//            quantityOption[itemId] = itemQuantity
//            print(quantityOption);
//        }
        
        for index in 0..<dictionaryArray.count {
            var dic = dictionaryArray[index]
            var quantityOption = dic!["option_qty"] as! [String:Any]
            let itemId = dic!["item_id"] as! String
            let  itemQuantity = dic!["item_qty"] as! Int
            quantityOption[itemId] = itemQuantity
            dic!["option_qty"] = quantityOption
            print(quantityOption);
            
            dictionaryArray[index] = dic
        }

        

        let dishJsonData = try? JSONSerialization.data(withJSONObject: dictionaryArray, options: [])
        
        
        let dishesjsonString = String(data: dishJsonData!, encoding: .utf8)
        
        
        let resturantid = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.id

        PNOrderManager.sharedInstance.ClearPlacedOrders(ResturantId:resturantid!, SuccessBlock: { (placedOrderclear) in
            print("clear")
//            let viewController = PNPlaceOrderSuccessViewController(nibName: "PNPlaceOrderSuccessViewController", bundle: nil)
//            viewController.price = self.placeOrderView.totalPriceLabel.text!;
//            self.navigationController?.pushViewController(viewController, animated: true)
            
            
            
            PNOrderManager.sharedInstance.AddToCartOrder(Items: dishesjsonString!, ResturantId: resturantid!,SuccessBlock: { (addToCart) in
                print("Response is ",addToCart);
            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else{
                    self.alert(title: "Error", message: "Something went wrong")
                }
            });
            
            
            
            
            
            
            
        }, FailureBlock: { (error) in
            if let localError = error as? ErrorBaseClass{
                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
                self.alert(title: "Error", message: "Something went wrong")
            }
        })
    
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "myTotalPrice")
        self.navigationController?.popViewController(animated: true)
    }
    
    func getNewSuggestionsTapped() {
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
