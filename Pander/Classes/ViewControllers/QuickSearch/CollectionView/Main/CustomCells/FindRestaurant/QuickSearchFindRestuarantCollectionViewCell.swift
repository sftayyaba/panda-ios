//
//  QuickSearchFindRestuarantCollectionViewCell.swift
//  Pander
//
//  Created by umaid naeem on 2/28/18.
//

import UIKit

class QuickSearchFindRestuarantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelBudgetPerPerson: UILabel!
    @IBOutlet weak var labelPeopleEating: UILabel!
    @IBOutlet weak var labelDeliverToLocation: UILabel!
    
    @IBOutlet weak var deliverAtTimeLabel: UILabel!
    
    public var didLocationButtonCallback : (() -> Void)?
    public var didDishesButtonCallback : (() -> Void)?
    public var didBudgetButtonCallback : (() -> Void)?
    public var didPeopleButtonCallback : (() -> Void)?
    public var didDeliveryButtonCallback : (() -> Void)?
    public var didFindRestaurentButtonCallback : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        if let callback = didLocationButtonCallback{
            callback()
        }
    }
    
    @IBAction func dishesButtonPressed(_ sender: Any) {
        if let callback = didDishesButtonCallback{
            callback()
        }
    }
    
    @IBAction func budgetButtonPressed(_ sender: Any) {
        if let callback = didBudgetButtonCallback{
            callback()
        }
        
    }
    
    @IBAction func peopleButtonPressed(_ sender: Any) {
        if let callback = didPeopleButtonCallback{
            callback()
        }
    }
    
    @IBAction func deliverASAPButtonPressed(_ sender: Any) {
        if let callback = didDeliveryButtonCallback{
            callback()
        }
        
    }
    
    @IBAction func findRestaurentButtonPressed(_ sender: Any) {
        if let callback = didFindRestaurentButtonCallback{
            callback()
        }
        
    }
    
    func setContent(){
        setLabelDeliverToLocation()
        setLabelPeopleEating()
        setLabelBudgetPerPerson()
        setLabelDeliverWhen()
    }
    
    private func setLabelDeliverToLocation() {
        let normalText = "Deliver to "
        var boldText = "current location"
        if let address = PNUserManager.sharedInstance.selectedAddress, let nick = address.nick {
            boldText = nick
        }
        
        
        if self.labelDeliverToLocation.text == "Deliver to current location" {
            PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
                
                if let addresses = response.addresses{
                    //self.locationTableView.addresses = addresses
                    if addresses.count != 0 {
                        self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
                            .normal(normalText)
                            .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)
                    }
                }
                
            }
                , FailureBlock: { (error) in
                    if let localError = error as? ErrorBaseClass{
                        //self.alert(title: "Oops", message: localError.localizedDescription)
                    }else {
                        // self.alert(title: "Error", message: "Something went wrong !")
                    }
                    
            })
        }else {
//            self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
//                .normal(normalText)
//                .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)
            
        }
    }
    
    
    
    private func setLabelPeopleEating() {
        let normalText = "People eating "
        let boldText = "\(PNUserManager.sharedInstance.groupSize) person"
        labelPeopleEating.attributedText = NSMutableAttributedString()
            .normal(normalText)
            .bold(boldText)
    }
    
    private func setLabelBudgetPerPerson() {
        let normalText = "Budget per person "
        let boldText = "$\(PNUserManager.sharedInstance.budgetPerPerson)"
        labelBudgetPerPerson.attributedText = NSMutableAttributedString()
            .normal(normalText)
            .bold(boldText)
        
        PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
            
            var cardarray = response.cards
            
            if response.cards?.count != 0 {
                PNUserManager.sharedInstance.selectedCard=response.cards?[0]
                if let selectedCard = PNUserManager.sharedInstance.selectedCard{
                    
                    //((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!)!)
                }
            }
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    //(self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                    // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })
    }
    
    private func setLabelDeliverWhen() {
        let normalText = "When to deliver "
        let boldText = "\(PNUserManager.sharedInstance.selectedDate)"
        deliverAtTimeLabel.attributedText = NSMutableAttributedString()
            .normal(normalText)
            .bold(boldText)
    }

}
