//
//  PNOrderDetailViewController.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailViewController: PNBaseViewController {

    
    @IBOutlet var orderDetailView: PNOrderDetailView!
    
    @IBOutlet var tableView: PNOrderDetailDelegateDatasource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        updateTotalPrice()
    }
    
    func updateTotalPrice(){
        if let totalPrice = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.reduce( Float(0) , { (result, dish) -> Float in
            return result + dish.price!
        }){
            self.orderDetailView.totalPriceLabel.text = "$"+totalPrice.format(f: "")
        }
    }
    
    override func configureView() {
        self.configureTableView()
    }
    
    override func configureCallBacks() {
        
        self.tableView.editAndReorderButtonCallback = {
            print("Edit Button pressed")
            var searchAddress = ""
            var city = ""
            var zip = ""
            var addressId = ""
            
            let dishesArray : NSMutableArray = NSMutableArray ()
            for i in 0..<3 {
                let dishDictionary :NSMutableDictionary = NSMutableDictionary()
                dishDictionary.setValue("name", forKey: "name")
                dishDictionary.setValue("1", forKey: "id")
                dishDictionary.setValue("3", forKey: "quantity")
                dishesArray.add(dishDictionary)
            }
            
            let dishJsonData = try? JSONSerialization.data(withJSONObject: dishesArray, options: [])
            let dishesjsonString = String(data: dishJsonData!, encoding: .utf8)
            
            
            let reorderInfoJsonObject: NSMutableDictionary = NSMutableDictionary()
            reorderInfoJsonObject.setValue("value1", forKey: "restId")
            reorderInfoJsonObject.setValue("value2", forKey: "restName")
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
                
            }, FailureBlock: { (error) in
                
            });
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
