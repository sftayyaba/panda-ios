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
    var totalBill = Float()

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Explanation: UILabel!
    
    @IBOutlet weak var  ResturantAddress1:UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
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
        
        let restaurantInfo = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo
        let orderCheckout = PNOrderManager.sharedInstance.checkOut

        UserName.text = "Hi, \(PNUserManager.sharedInstance.user?.firstName ?? "")"
        Explanation.text = StringConstants.orderCheckoutSuccessMessage.replacingOccurrences(of: StringConstants.restaurantNamePlaceholder, with: restaurantInfo?.name ?? "")
        if let orderId = orderCheckout?.orderId {
            orderNumberLbl.text = "\(orderId)"
        }
        totalPrice.text = "$\(totalBill)"

        self.ResturantName.text = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.name

        let restaurantAddress = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.restaurantInfo?.address
        let addressComponents = (restaurantAddress ?? "").components(separatedBy: "-SPLITTER-")
        ResturantAddress1.text = addressComponents.first
        ResturantAddress.text = addressComponents.last

        self.numberuser.text = PNUserManager.sharedInstance.selectedAddress?.phone
        var string = PNUserManager.sharedInstance.selectedAddress?.city!
        string = string! + ", " + (PNUserManager.sharedInstance.selectedAddress?.state!)!
        string = string! + ", " + (PNUserManager.sharedInstance.selectedAddress?.zipCode!)!
        self.buddinsaddress2.text = string
        self.buddinsaddress.text = (PNUserManager.sharedInstance.selectedAddress?.street!)!
    }
    
    override func configureCallBacks() {
    }
    
    @IBAction func detailButtonClick(_ sender: Any) {
        let orderDetailsView = OrderDetailsView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 280.0)))
        orderDetailsView.showOn(view: view)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
