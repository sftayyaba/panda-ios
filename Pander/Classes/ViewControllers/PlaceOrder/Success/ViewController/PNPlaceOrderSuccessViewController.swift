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
    
    @IBOutlet weak var  ResturantAddress1:UILabel!
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
        var val = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.address
      let chekc = val?.split(separator: "-")
        val = String(chekc![0]) + String(chekc![1])
        self.ResturantAddress.text = String(chekc![2])
        self.ResturantAddress1.text = val
        self.numberuser.text = PNUserManager.sharedInstance.selectedAddress?.phone
        var string = PNUserManager.sharedInstance.selectedAddress?.city!
        string = string! + ", " + (PNUserManager.sharedInstance.selectedAddress?.state!)!
        string = string! + ", " + (PNUserManager.sharedInstance.selectedAddress?.zipCode!)!
        self.buddinsaddress2.text = string
        self.buddinsaddress.text = (PNUserManager.sharedInstance.selectedAddress?.street!)!
        print(PNUserManager.sharedInstance.selectedAddress?.nick!)
       // print(string)
        //self.buddinsaddress.text = "\(PNUserManager.sharedInstance.selectedAddress?.city,PNUserManager.sharedInstance.selectedAddress?.state)"
        //\(PNUserManager.sharedInstance.selectedAddress?.locationId!),\(PNUserManager.sharedInstance.selectedAddress?.street!)"
        self.Explanation.text = "N A"
        
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func detailButtonClick(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
