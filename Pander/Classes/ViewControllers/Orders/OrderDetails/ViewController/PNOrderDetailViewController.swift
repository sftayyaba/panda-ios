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
        
//        self.tableView.didAddItemButtonCallback={
//            let viewController = PNPlaceOrderAddItemRootViewController(nibName: "PNPlaceOrderAddItemRootViewController", bundle: nil)
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
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
