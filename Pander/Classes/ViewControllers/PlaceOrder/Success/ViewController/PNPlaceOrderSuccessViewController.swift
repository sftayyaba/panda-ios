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

class PNPlaceOrderSuccessViewController: PNBaseViewController {
    
    var price = ""
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Explanation: UILabel!
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet var placeOrderSuccessView: PNPlaceOrderSuccessView!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var detailsbtn: UIButton!
    @IBOutlet weak var ResturantName: UILabel!
    @IBOutlet weak var ResturantAddress: UILabel!
    @IBOutlet weak var numberuser: UILabel!
    @IBOutlet weak var buddinsaddress: UILabel!
    
    @IBOutlet weak var buddinsaddress2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.totalPrice.text=price
        
        self.UserName.text = "Hi, \((PNUserManager.sharedInstance.user?.firstName)!)"
        self.ResturantName.text = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.name
        self.ResturantAddress.text = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.address
        self.numberuser.text = PNUserManager.sharedInstance.selectedAddress?.phone
        self.buddinsaddress.text = "\((PNUserManager.sharedInstance.selectedAddress?.city)!,(PNUserManager.sharedInstance.selectedAddress?.state)!, (PNUserManager.sharedInstance.selectedAddress?.locationId)!,(PNUserManager.sharedInstance.selectedAddress?.street)!)"
        self.Explanation.text = "N A"
        
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func detailButtonClick(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
