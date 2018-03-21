//
//  PNOrderDetailDelegateDatasource.swift
//  Pander
//
//  Created by umaid naeem on 2/27/18.
//

import UIKit

class PNOrderDetailDelegateDatasource: UITableView,UITableViewDelegate,UITableViewDataSource {

    public var  didAddItemButtonCallback : (() -> Void)?
    public var didRemoveItemButtonCallback : ((PNCart) -> Void)?
    
    public var editAndReorderButtonCallback : (() -> Void)?
    public var reorderButtonCallback : (() -> Void)?
    
    
    public var didPressShowAddressCallback : (() -> Void)?
    public var didPressShowCardCallback : (() -> Void)?
    
    
    var isLocationSelected = false
    var isPaymentSelected = false
    var cuisine = String()
    var order : PNOrders!
    
    
    
    var numberofCards = PNUserManager.sharedInstance.cardsBaseObject?.cards?.count
    var numberofLocations = PNUserManager.sharedInstance.addresses!.count
    
    
     var numberofSectionHeaders = 5
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSectionHeaders
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0 && (isLocationSelected || isPaymentSelected)) {
            if isLocationSelected {
                return numberofLocations + 1
            }else {
                return numberofCards! + 1
            }
        }else if section == 2{
            if order == nil {
                return 0
            }else {
                return order.cart!.count
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 53
        }else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }else if section == 1 {
            return 320
        }else if section == 2 {
            if cuisine == "0" {
                return 60
            }else {
               return 0
            }
        }else if section == 3 {
            return 180
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && (isLocationSelected || isPaymentSelected) {
            return self.tableView(tableView, cellForLocationsOptionAt: indexPath)
        }else if indexPath.section == 2{
            return self.tableView(tableView, cellForPaymentOptionAt: indexPath)
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return self.tableView(tableView, headerForLocationOptionAt: section)
        }else if section == 1{
            return self.tableView(tableView, headerForAddItemsOptionAt: section)
        }else if section == 2 {
            let cell: PNOrderDetailAddItemTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNOrderDetailAddItemTableViewCell") as? PNOrderDetailAddItemTableViewCell)!
            cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
            
            return cell
        }else if (section == 3){
            return self.tableView(tableView, headerForOrderDetailTotalOptionAt: section)
        }else {
           return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, headerForLocationOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNOrderDetailLocationHeaderViewTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNOrderDetailLocationHeaderViewTableViewCell") as? PNOrderDetailLocationHeaderViewTableViewCell)!
        
        cell.didCloseButtonCallback = { index in
            self.isLocationSelected = false
            
            if index == 0 {
                self.isPaymentSelected = false
            }else {
                self.isPaymentSelected = false
            }
            
            self.reloadData()
        }
        
        cell.didOpenButtonCallback = { index in
            
            if index == 0 {
                self.isLocationSelected = true
                self.isPaymentSelected = false
            }else {
                self.isLocationSelected = false
                self.isPaymentSelected = true
            }
            
            self.reloadData()
        }
        
        cell.locationButton.isSelected = self.isLocationSelected
        cell.paymentButton.isSelected  = self.isPaymentSelected
        cell.setContent()
        return cell
    }
    
    //MARK: Section 0 Cells
    func tableView(_ tableView: UITableView, cellForAddLocationOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNAddLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNAddLocationTableViewCell") as? PNAddLocationTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForLocationsOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderLocationTableViewCell") as? PNPlaceOrderLocationTableViewCell)!
        
        
        if self.isLocationSelected {
            let locations = numberofLocations
            if(indexPath.row==locations){
                let cell:PNAddLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNAddLocationTableViewCell") as? PNAddLocationTableViewCell)!
                cell.address.text="Add new delivery Address"
                return cell
            }else{
                let address = PNUserManager.sharedInstance.addresses![indexPath.row]
                cell.setContent(address: address)
            }
            
        }else {
            let cards = numberofCards
            if(indexPath.row==cards){
                let cell:PNAddLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNAddLocationTableViewCell") as? PNAddLocationTableViewCell)!
                cell.address.text="Add new payment method"
                return cell
            }else{
                let card = PNUserManager.sharedInstance.cardsBaseObject?.cards![indexPath.row]
                cell.setCardContent(card: card!)
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForCurrentLocationOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderCurrentLocationTableViewCell") as? PNPlaceOrderCurrentLocationTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForPaymentOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNOrderDetailPaymentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNOrderDetailPaymentTableViewCell") as? PNOrderDetailPaymentTableViewCell)!
        let cart = order.cart![indexPath.row]
        cell.setContent(cart: cart,order: order,indexPath: indexPath)
        
        cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
        cell.didRemoveItemButtonCallback = self.didRemoveItemButtonCallback;
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForItemsOptionAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNPlaceOrderItemsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderItemsTableViewCell") as? PNPlaceOrderItemsTableViewCell)!
        
        return cell
    }
    
    
    //MARK: Section Headers
    func tableView(_ tableView: UITableView, headerForAddItemsOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNOrderDetailImageSliderTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNOrderDetailImageSliderTableViewCell") as? PNOrderDetailImageSliderTableViewCell)!
        cell.setContent(cuisine: cuisine,order: order)
        cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, headerForOrderDetailTotalOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNOrderDetailTotalTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNOrderDetailTotalTableViewCell") as? PNOrderDetailTotalTableViewCell)!
        cell.editAndReorderButtonCallback = self.editAndReorderButtonCallback;
        cell.reorderButtonCallback = self.reorderButtonCallback;
        cell.setContent(cuisine: cuisine,order: order)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // Create the actions
            if self.isLocationSelected {
                let alertController = UIAlertController(title: "", message: "Are you sure you want to change your address?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    
                    let selected = self.numberofLocations
                    if(indexPath.row==selected){
                        
                    if let callback = self.didPressShowAddressCallback{
                        callback();
                    }
                        print("add new location")

                    }else {
                        let address = PNUserManager.sharedInstance.addresses![indexPath.row]
                        address.isSelected = !address.isSelected
                        
                        var selectDefault = false
                        if !address.isSelected{
                            selectDefault = true
                        }
                        
                        var selectedAddress = address;
                        PNUserManager.sharedInstance.addresses = PNUserManager.sharedInstance.addresses?.map { (currentAddress) -> PNAddresses in
                            
                            if (address.locationId != currentAddress.locationId){
                                currentAddress.isSelected = false
                            }
                            
                            if selectDefault && currentAddress.isDefault{
                                currentAddress.isSelected = true;
                                selectedAddress = currentAddress
                            }
                            
                            return currentAddress
                        }
                        
                        PNUserManager.sharedInstance.selectedAddress = selectedAddress
                        
                        self.isLocationSelected = false
                        self.isPaymentSelected = false
                        self.reloadData()
                        
                    }
                    }
                
                let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            }else {
                //Do work here When Different Card is selected for Order
                    let alertController = UIAlertController(title: "", message: "Are you sure you want to change your card?", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        
                        let cards = self.numberofCards
                        if(indexPath.row==cards){
                            print("Add cards");
                            if let callback = self.didPressShowCardCallback{
                                callback();
                            }

                        }else {
                            if  let card = PNUserManager.sharedInstance.cardsBaseObject?.cards![indexPath.row] {
                                
                                card.isSelected = !card.isSelected
                                var selectDefault = false
                                
                                if !card.isSelected{
                                    selectDefault = true
                                }
                                
                                var selectedCard = card;
                                PNUserManager.sharedInstance.cardsBaseObject?.cards = PNUserManager.sharedInstance.cardsBaseObject?.cards?.map { (currentCard) -> PNCards in
                                    
                                    if (card.ccId != currentCard.ccId){
                                        currentCard.isSelected = false
                                    }
                                    
                                    if selectDefault && currentCard.isDefault{
                                        currentCard.isSelected = true;
                                        selectedCard = currentCard
                                    }
                                    
                                    return currentCard
                                }
                                
                                PNUserManager.sharedInstance.selectedCard = selectedCard
                                self.isLocationSelected = false
                                self.isPaymentSelected = false
                                self.reloadData()
                            }
                            
                        }
                        }
                    
                    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            
        }else if indexPath.section == 2{
            
            let cart = order.cart![indexPath.row]
            cart.isSelected = !cart.isSelected
            reloadData()
        }
    }
}
