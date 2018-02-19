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
        PNUserManager.sharedInstance.getAddresses(SuccessBlock: { (response) in
            
           // self.addresses = response.addresses
            
            if let addresses = response.addresses{
                //self.locationTableView.addresses = addresses
                self.labelDeliverToLocation.attributedText = NSMutableAttributedString()
                .normal(normalText)
                    .bold((PNUserManager.sharedInstance.selectedAddress?.nick != nil ? PNUserManager.sharedInstance.selectedAddress?.nick : PNUserManager.sharedInstance.selectedAddress?.street)!)
            }
            
//            if self.isNewAddressAdded {
//                self.navigationController?.popViewController(animated: true)
//            }
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    //self.alert(title: "Oops", message: localError.localizedDescription)
                }else {
                   // self.alert(title: "Error", message: "Something went wrong !")
                }
                
        })

       // labelDeliverToLocation.attributedText = NSMutableAttributedString()
                //.normal(normalText)
                //.bold(boldText)
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
          print(PNUserManager.sharedInstance.selectedCard?.nick!)
            var cardarray = response.cards
            self.labelBudgetPerPerson.attributedText  = NSMutableAttributedString()
                .normal(normalText)
                .bold(cardarray![0].nick != nil ? cardarray![0].nick! : cardarray![0].type! + cardarray![0].lastFour!)
            if let cards = response.cards{
                print(cards)
                print(PNUserManager.sharedInstance.budgetPerPerson)
                //self.labelBudgetPerPerson.attributedText = NSMutableAttributedString()
                       // .normal(normalText)
                       // .bold((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type!)!)
            }
            if let selectedCard = PNUserManager.sharedInstance.selectedCard{
                self.labelBudgetPerPerson.attributedText = NSMutableAttributedString()
                    .normal(normalText)
                    .bold((PNUserManager.sharedInstance.selectedCard?.nick != nil ? PNUserManager.sharedInstance.selectedCard?.nick : PNUserManager.sharedInstance.selectedCard!.type! + PNUserManager.sharedInstance.selectedCard!.lastFour!)!)
            }
            //self.budgetTableView.cardsArray = self.cardsArray
            //self.budgetTableView.reloadData()
            
//            if self.isNewCardAdded {
//                self.navigationController?.popViewController(animated: true)
//            }
            
            //                self.alert(title: "Success", message: "Address added to your account")
            //    }
            
        }
            , FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
                    //self.alert(title: "Oops", message: localError.localizedDescription)
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
