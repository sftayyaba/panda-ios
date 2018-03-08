//
//  FindRestuarantCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 30/01/2018.
//

import UIKit

class FindRestuarantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelBudgetPerPerson: UILabel!
    @IBOutlet weak var labelPeopleEating: UILabel!
    @IBOutlet weak var labelDeliverToLocation: UILabel!

    @IBOutlet weak var deliverAtTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public var didLocationButtonCallback : (() -> Void)?
    public var didDishesButtonCallback : (() -> Void)?
    public var didBudgetButtonCallback : (() -> Void)?
    public var didPeopleButtonCallback : (() -> Void)?
    public var didDeliveryButtonCallback : (() -> Void)?
    public var didFindRestaurentButtonCallback : (() -> Void)?

    
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
                       PNUserManager.sharedInstance.selectedAddress=addresses[0]
                       // if(addresses[0].isSelected){
                       //self.locationTableView.addresses = addresses
                       if addresses.count != 0 {
                        
                           self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
                               .normal(normalText)
                              .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)
                       }
                   // }
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
            self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
                .normal(normalText)
                .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)

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
//        let normalText = "Budget per person "
//        let boldText = "$\(PNUserManager.sharedInstance.budgetPerPerson)"
//        labelBudgetPerPerson.attributedText = NSMutableAttributedString()
//            .normal(normalText)
//            .bold(boldText)
//<<<<<<< HEAD
//
//        PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
//
//            var cardarray = response.cards
//
//            if response.cards?.count != 0 {
//                PNUserManager.sharedInstance.selectedCard=response.cards?[0]
//                if let selectedCard = PNUserManager.sharedInstance.selectedCard{
//
//                    //((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!)!)
//=======
//        if(PNUserManager.sharedInstance.selectedCard==nil){
//            PNUserManager.sharedInstance.getCards(SuccessBlock: { (response) in
//
//                var cardarray = response.cards
//
//                if response.cards?.count != 0 {
//                    PNUserManager.sharedInstance.selectedCard=response.cards?[0]
//                    if let selectedCard = PNUserManager.sharedInstance.selectedCard{
//
//                        //((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!)!)
//                    }
//>>>>>>> 8430edde10c6787f8e84c25980e49068ad650c1f
//                }
//
//            }
//                , FailureBlock: { (error) in
//                    if let localError = error as? ErrorBaseClass{
//                        //(self.alert(title: "Oops", message: localError.localizedDescription)
//                    }else {
//                        // self.alert(title: "Error", message: "Something went wrong !")
//                    }
//
//            })
//        }else{
//
//        }
        
    }

    private func setLabelDeliverWhen() {
        let normalText = "When to deliver "
        let boldText = "\(PNUserManager.sharedInstance.selectedDate)"
        deliverAtTimeLabel.attributedText = NSMutableAttributedString()
            .normal(normalText)
            .bold(boldText)
    }
}

extension NSMutableAttributedString {
    
    @discardableResult func redbold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!, .foregroundColor: UIColor.customRedColor()]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }

    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-DemiBold", size: 14)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
