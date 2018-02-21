//
//  PNPlaceOrderLocationHeaderViewTableViewCell.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNPlaceOrderLocationHeaderViewTableViewCell: UITableViewCell {
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var paymentButton: UIButton!
    //    @IBOutlet var locationButton: UIButton!
//    @IBOutlet var paymentButton: UIButton!

    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var paymentLabel: UILabel!

    @IBOutlet var locationImage: UIImageView!
    @IBOutlet var paymentImage: UIImageView!

    //MARK: Callbacks
    public var didCloseButtonCallback : ((_ index: Int) -> Void)?
    public var didOpenButtonCallback : ((_ index: Int) -> Void)?

    @IBAction func locationButtonTapped(_ sender: Any) {
        
        if locationButton.isSelected {
            if let callBack = didCloseButtonCallback {
                callBack(0)
            }
            self.locationImage.image = UIImage(named: "Arrow - Big - down - Black")
            self.locationButton.isSelected = false
        }else {
            if let callBack = didOpenButtonCallback {
                callBack(0)
            }

            self.locationButton.isSelected = true
            self.locationImage.image = UIImage(named: "Arrow - Big - Up - Black")
        }
    }
    
    @IBAction func paymentButtonTapped(_ sender: Any) {
        
        if paymentButton.isSelected {
            self.paymentButton.isSelected = false
            self.paymentImage.image = UIImage(named: "Arrow - Big - down - Black")
            if let callBack = didCloseButtonCallback {
                callBack(1)
            }
        }else {
            if let callBack = didOpenButtonCallback {
                callBack(1)
            }
            
            self.paymentButton.isSelected = true
            self.paymentImage.image = UIImage(named: "Arrow - Big - Up - Black")
        }
    }
    
    func setContent(){
        if let callBack = didCloseButtonCallback {
            
        }
        if let selectedCard = PNUserManager.sharedInstance.selectedCard{
//            self.paymentLabel.text = PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!
            self.paymentLabel.text = PNUserManager.sharedInstance.selectedCard!.lastFour!
            
        } else {
            self.paymentLabel.text = " - "
        }
        
        if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
            self.locationLabel.text =
                PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street
        }
    }
}
