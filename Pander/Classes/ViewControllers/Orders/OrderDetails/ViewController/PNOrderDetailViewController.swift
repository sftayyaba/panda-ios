//
//  PNOrderDetailViewController.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

//cusine = 0 //Scheduled Orders
//cusine = 1 //Past Orders

import UIKit

class PNOrderDetailViewController: PNBaseViewController {

    
    @IBOutlet var orderDetailView: PNOrderDetailView!
    
    @IBOutlet var tableView: PNOrderDetailDelegateDatasource!
    
    var cuisine = String()
    var order : PNOrders!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
            PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
                
            }
                , FailureBlock: { (error) in
                    if (error as? ErrorBaseClass) != nil{
                        //(self.alert(title: "Oops", message: localError.localizedDescription)
                    }else {
                        // self.alert(title: "Error", message: "Something went wrong !")
                    }
                    
            })
        }
         , FailureBlock: { (error) in
                if (error as? ErrorBaseClass) != nil{
                    //self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
        })
        
        
        PNOrderManager.sharedInstance.getPastOrderWithID(OrderID:self.order.orderId!, SuccessBlock:{ (response) in
            
        }
            , FailureBlock: { (error) in
                if (error as? ErrorBaseClass) != nil{
                    //(self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
        
        tableView.order = self.order
        tableView.cuisine = self.cuisine
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        updateTotalPrice()
    }
    
    func updateTotalPrice(){
//        if let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
//            return result + dish.price!
//        }){
//            self.orderDetailView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
//        }
    }
    
    override func configureView() {
        self.configureTableView()
    }
    
    func showErrorAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        alertController.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func checkCardIdExistence() {
        
        PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
            
            let cardsArray = response.cards!
            
            for card in cardsArray {
                //TODO: change orderId to relevant credit card id
                if self.order.orderId == card.ccId! {
                    //success
                    //do something
                    return
                }
            }
            self.showErrorAlert("Credit Card Information not found in user account")
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
    }
    
    func checkLocations() {
        
            PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in

                print("Locations: \(response)")

                if let successResponse = response as? PNGetAddressesResponse {
                    for address in successResponse.addresses! {
                        if address.locationId == Int(self.order.locationId!) {
                            //yes
                            //go to next step
//                            self.checkCardIdExistence()
                            self.tableView.reorderButtonCallback!()
                            return
                        }
                    }
                    self.showErrorAlert("Location not found in user account")
                }


            }, FailureBlock: { (error) in
            })
    }
    
    func checkMerchantOpenHours() {
       
        PNMerchantManager.sharedInstance.getMerchantHours(SuccessBlock: {
            (merchantHours) in
            
            let currentDelivery = merchantHours.currentSchedule!.delivery!
            print("Current Delivery: \(currentDelivery)")
            let currentTime = Date()
            let currentDay = currentTime.dayOfWeek()!.lowercased()
            let timesOpen = currentDelivery[currentDay]!.timesOpen![0].start!
            let timeClosed = currentDelivery[currentDay]!.timesOpen![0].end!
            
            let f = DateFormatter()
            f.dateFormat = "HH:mm"
            
            let startDate = f.date(from: timesOpen)!
            let endDate = f.date(from: timeClosed)!
            
            let gregorian = Calendar(identifier: .gregorian)
            var startComponents = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime)
            var endComponents = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentTime)
            
            var componentsForStart = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate)
            var componentsForEnd = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate)
            
            // Change the time to 9:30:00 in your locale
            startComponents.hour = componentsForStart.hour
            startComponents.minute = componentsForStart.minute
            startComponents.second = componentsForStart.second
            
            endComponents.hour = componentsForEnd.hour
            endComponents.minute = componentsForEnd.minute
            endComponents.second = componentsForEnd.second
            
            let startTime = gregorian.date(from: startComponents)!
            let endTime = gregorian.date(from: endComponents)!
            
            if currentTime.timeIntervalSince1970 > startTime.timeIntervalSince1970 && currentTime.timeIntervalSince1970 < endTime.timeIntervalSince1970 {
                print("YESSS!!")
                self.checkLocations()
            } else {
                self.showErrorAlert("Merchant is closed now!")
            }
            
            }, FailureBlock: {
                (error) in
            })
    }
    
    override func configureCallBacks() {
        
        self.tableView.editAndReorderButtonCallback = {
            
            
            if self.cuisine == "0" {
                print("Scheduled Orders")
                //Write Contact Method Here For Scheduled orders
                let busPhone = self.order.phone!
                if let url = URL(string: "tel://\(busPhone)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }

            }else {
                print("Past Orders")
                //Write Edit & Reorder Here For Scheduled orders
                print("Edit Button pressed")
                var searchAddress = ""
                var city = ""
                var zip = ""
                var addressId = ""
    
                let dishesArray : NSMutableArray = NSMutableArray ()
                for cart in self.order.cart! {
                    let dishDictionary :NSMutableDictionary = NSMutableDictionary()
                    dishDictionary.setValue(cart.name, forKey: "name")
                    dishDictionary.setValue(cart.id, forKey: "id")
                    dishDictionary.setValue(cart.quantity, forKey: "quantity")
                    dishesArray.add(dishDictionary)
                }
    
                let dishJsonData = try? JSONSerialization.data(withJSONObject: dishesArray, options: [])
                let dishesjsonString = String(data: dishJsonData!, encoding: .utf8)
    
    
                let reorderInfoJsonObject: NSMutableDictionary = NSMutableDictionary()
                reorderInfoJsonObject.setValue(self.order.merchantId, forKey: "restId")
                reorderInfoJsonObject.setValue(self.order.name, forKey: "restName")
                reorderInfoJsonObject.setValue(dishesjsonString!, forKey: "dishes")
                let reorderInfoJsonData = try? JSONSerialization.data(withJSONObject: reorderInfoJsonObject, options: [])
                let reorderInfoJsonString = String(data: reorderInfoJsonData!, encoding: .utf8)
    
    
    
                if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
                    searchAddress = "\(selectedAddress.street!),\(selectedAddress.zipCode!)"
                    city = selectedAddress.city!
                    zip = selectedAddress.zipCode!
                    addressId = "\(selectedAddress.locationId!)"
                }else{
                    self.alert(title: "Oops", message: "No Delivery address is selected.")
                    return
                }
    
                PNOrderManager.sharedInstance.recreateOrder(SearchAddress: searchAddress, AddressCity: city, AddressZip: zip, AddressId: addressId, ReorderInfo: reorderInfoJsonString!, SuccessBlock: { (generatedOrderResponse) in
                    PNOrderManager.sharedInstance.getGeneratedOrder(TaskId: generatedOrderResponse.id!, SuccessBlock: { (orderReponse) in
                        if orderReponse.internalStatus == -1 {
                            self.alert(title: "Oops", message: "There seems to be no restaurants available. Please choose another address");
                        } else {
                            let viewController = PNPlaceOrderViewController(nibName: "PNPlaceOrderViewController", bundle: nil)
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }, FailureBlock: { (error) in
                        if let localError = error as? ErrorBaseClass{
                            self.alert(title: "Oops", message: localError.localizedDescription)
                        }else{
                            self.alert(title: "Error", message: "Something went wrong")
                        }
                    })
                }, FailureBlock: { (error) in
                    if let localError = error as? ErrorBaseClass{
                        self.alert(title: "Oops", message: localError.localizedDescription)
                    }else{
                        self.alert(title: "Error", message: "Something went wrong")
                    }
    
                });
            }
            
        }
        
//        func checkLocations(completionHandler: @escaping (_ ))
     
        
        func editAndReorder () {
            
        }
        
        
        
        
        self.tableView.checkPreConditions = {
            
            self.checkMerchantOpenHours()
            
        }
        
        
        self.tableView.reorderButtonCallback = {
           
            if self.cuisine == "0" {
                print("Scheduled Orders")
                //Write Edit & Order Here For Scheduled orders
                var searchAddress = ""
                var city = ""
                var zip = ""
                var addressId = ""
    
                let dishesArray : NSMutableArray = NSMutableArray ()
                for cart in self.order.cart! {
                    let dishDictionary :NSMutableDictionary = NSMutableDictionary()
                    dishDictionary.setValue(cart.name, forKey: "name")
                    dishDictionary.setValue(cart.id, forKey: "id")
                    dishDictionary.setValue(cart.quantity, forKey: "quantity")
                    dishesArray.add(dishDictionary)
                }
    
                let dishJsonData = try? JSONSerialization.data(withJSONObject: dishesArray, options: [])
                let dishesjsonString = String(data: dishJsonData!, encoding: .utf8)
    
    
                let reorderInfoJsonObject: NSMutableDictionary = NSMutableDictionary()
                reorderInfoJsonObject.setValue(self.order.merchantId, forKey: "restId")
                reorderInfoJsonObject.setValue(self.order.name, forKey: "restName")
                reorderInfoJsonObject.setValue(dishesjsonString!, forKey: "dishes")
                let reorderInfoJsonData = try? JSONSerialization.data(withJSONObject: reorderInfoJsonObject, options: [])
                let reorderInfoJsonString = String(data: reorderInfoJsonData!, encoding: .utf8)
    
    
    
                if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
                    searchAddress = "\(selectedAddress.street!),\(selectedAddress.zipCode!)"
                    city = selectedAddress.city!
                    zip = selectedAddress.zipCode!
                    addressId = "\(selectedAddress.locationId!)"
                }else{
                    self.alert(title: "Oops", message: "No Delivery address is selected.")
                    return
                }
    
    
                PNOrderManager.sharedInstance.recreateOrder(SearchAddress: searchAddress, AddressCity: city, AddressZip: zip, AddressId: addressId, ReorderInfo: reorderInfoJsonString!, SuccessBlock: { (response) in
                    self.alert(title: "Success", message: "Successfully recreated order.")
                }, FailureBlock: { (error) in
                    if let localError = error as? ErrorBaseClass{
                        self.alert(title: "Oops", message: localError.localizedDescription)
                    }else{
                        self.alert(title: "Error", message: "Something went wrong")
                    }
    
                });
            }else {
                print("Past Orders")
                //Write Re Order call for past order here
                PNOrderManager.sharedInstance.reOrder(OrderId: self.order.orderId!, SuccessBlock: { (orders) in
                    print("succes");
                    self.alert(title: "Success", message: "Successfully re-orderd.")
                }, FailureBlock: { (error) in
                    if let localError = error as? ErrorBaseClass{
                        self.alert(title: "Oops", message: localError.localizedDescription)
                    }else{
                        self.alert(title: "Error", message: "Something went wrong")
                    }
                })

            }
        }
        
        
        self.tableView.didPressShowAddressCallback = {
            let viewController = PNLocationViewController(nibName: "PNLocationViewController", bundle: nil)
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        self.tableView.didPressShowCardCallback = {
            let viewController = PNBudgetVC(nibName: "PNBudgetVC", bundle: nil)
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        
        self.tableView.didAddItemButtonCallback = {
            return // Temp fix to avoid crash
            let viewController = PNPlaceOrderAddItemRootViewController(nibName: "PNPlaceOrderAddItemRootViewController", bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)

        }

        tableView.detailsButtonCallback = {
            return // Temporary
            let orderDetailsView = OrderDetailsView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: 280.0)))
            orderDetailsView.showOn(view: self.view, orderItems: nil, cartItems: self.order.cart)
        }
    }
    
    fileprivate func configureTableView() {
        
        let cellNib = UINib(nibName: "PNOrderDetailLocationHeaderViewTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "PNOrderDetailLocationHeaderViewTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNOrderDetailImageSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "PNOrderDetailImageSliderTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNOrderDetailItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "PNOrderDetailItemsTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderLocationTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNPlaceOrderPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPlaceOrderPaymentTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNOrderDetailTotalTableViewCell", bundle: nil), forCellReuseIdentifier: "PNOrderDetailTotalTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNOrderDetailAddItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PNOrderDetailAddItemTableViewCell")
        
        
        //MARK: Location Cells
        self.tableView.register(UINib(nibName: "PNOrderDetailPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "PNOrderDetailPaymentTableViewCell")
        
        self.tableView.register(UINib(nibName: "PNAddLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNAddLocationTableViewCell")
        
        
        
        self.tableView.dataSource = self.tableView
        self.tableView.delegate = self.tableView
        self.tableView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "myTotalPrice")
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(nil, forKey: "detailTotalPrice")
    }

}
