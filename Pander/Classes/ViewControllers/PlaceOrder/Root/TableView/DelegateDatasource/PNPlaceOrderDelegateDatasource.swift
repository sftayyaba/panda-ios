//
//  PNPlaceOrderDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNPlaceOrderDelegateDatasource: UITableView,UITableViewDelegate,UITableViewDataSource {
    public var didAddItemButtonCallback : (() -> Void)?

    
    
    var isLocationSelected = false
    var isPaymentSelected = false
    
    
    var numberofLocations = PNUserManager.sharedInstance.addresses!.count
    var numberofCards = PNUserManager.sharedInstance.cardsBaseObject?.cards?.count
    
    var numberofSectionHeaders = 3
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSectionHeaders
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0 && (isLocationSelected || isPaymentSelected)) {
            if isLocationSelected {
                return numberofLocations+1
            }else {
                return numberofCards!+1
            }
        }else if section == 2{
            if let count = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.count{
                return count
            }else{
                return 0
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
        }else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, headerForLocationOptionAt section: Int) -> UITableViewCell {
    
        let cell: PNPlaceOrderLocationHeaderViewTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderLocationHeaderViewTableViewCell") as? PNPlaceOrderLocationHeaderViewTableViewCell)!

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
            
//            self.isLocationSelected = true
            
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
        let cell: PNPlaceOrderPaymentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderPaymentTableViewCell") as? PNPlaceOrderPaymentTableViewCell)!
        if let dish = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?[indexPath.row]{
            cell.setContent(dish: dish)
        }
        
        cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForItemsOptionAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNPlaceOrderItemsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderItemsTableViewCell") as? PNPlaceOrderItemsTableViewCell)!
        
        return cell
    }
    
    
    //MARK: Section Headers
    func tableView(_ tableView: UITableView, headerForAddItemsOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNPlaceOrderImageSliderTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderImageSliderTableViewCell") as? PNPlaceOrderImageSliderTableViewCell)!
        
        cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // Create the actions
            if self.isPaymentSelected{
                let cards = numberofCards
                if(indexPath.row==cards){
                 
                    
                    let viewController = PNBudgetViewController(nibName: "PNBudgetVC", bundle: nil)
                    
                    UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true, completion: nil)

                   
                    print("add new")
                    
                    
                }else{
                    
                let card = PNUserManager.sharedInstance.cardsBaseObject;
                var mycard = card?.cards![indexPath.row];
               
                
                let payment = PNUserManager.sharedInstance.selectedCard
                payment?.isSelected=false
                payment?.isDefault=false
                mycard?.isSelected=true
                mycard?.isDefault=true
                payment?.isSelected = !(payment?.isSelected)!
                
                
                var selectDefault = false
                if !(payment?.isSelected)!{
                    selectDefault = true
                }
                if(payment?.ccId != mycard?.ccId){
                    payment?.isSelected=false
                }
                if selectDefault && (payment?.isDefault)!{
                    payment?.isSelected = true;
                    mycard = payment
                }
                PNUserManager.sharedInstance.selectedCard = mycard
                numberofCards=0;
                self.refreshData()
                self.reloadData()
                 numberofCards = PNUserManager.sharedInstance.cardsBaseObject?.cards?.count
            }
            }
            if self.isLocationSelected {
                
                let alertController = UIAlertController(title: "", message: "Are you sure you want to change your address?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    let selected = self.numberofLocations
                    if(indexPath.row==selected){
                        let viewController = PNLocationViewController(nibName: "PNLocationViewController", bundle: nil)
                        UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true, completion: nil)
                        
                        
                        //self.navigationController?.pushViewController(viewController, animated: true)
                        print("add new location")
                        
                    }else{
                        
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
                    self.refreshData()
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
            }
            
        }else if indexPath.section == 2{
            if let dish = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?[indexPath.row]{
             dish.isSelected = !dish.isSelected
                
                reloadData()
            }
        }
    }
    
    
    func refreshData()  {
        var searchAddress = ""
        var city = ""
        var zip = ""
        var addressId = ""
        let category = 2
        var cuisine = ""
        let groupSize = PNUserManager.sharedInstance.groupSize
        let budgetPerPerson = PNUserManager.sharedInstance.budgetPerPerson
        let orderMode = 0
        
        if let selectedAddress = PNUserManager.sharedInstance.selectedAddress{
            searchAddress = "\(selectedAddress.street!),\(selectedAddress.zipCode!)"
            city = selectedAddress.city!
            zip = selectedAddress.zipCode!
            addressId = "\(selectedAddress.locationId!)"
        }else{
//            self.alert(title: "Oops", message: "No Delivery address is selected.")
            return
        }
        
        if let selectedCuisines = PNUserManager.sharedInstance.homeSelectedCuisines{
            cuisine = selectedCuisines.joined(separator: ",")
        }else{
//            self.alert(title: "Oops", message: "No Cuisine is selected.")
            return
        }
        
        if let selectedCard = PNUserManager.sharedInstance.selectedCard{
            //            cuisine = selectedCuisines.joined(separator: ",")
        }else{
//            self.alert(title: "Oops", message: "No Card is selected.")
            return
        }
        PNOrderManager.sharedInstance.generateOrder(SearchAddress: searchAddress, AddressCity: city, AddressZip: zip, AddressId: addressId, Catergory: category, Cuisine: cuisine, GroupSize: groupSize, BudgetPerPerson: budgetPerPerson, OrderMode: orderMode, RestsTried: nil, SuccessBlock: { (generatedOrderResponse) in
            
            PNOrderManager.sharedInstance.getGeneratedOrder(TaskId: generatedOrderResponse.id!, SuccessBlock: { (orderReponse) in
                
                if(orderReponse.internalStatus == -1) {
//                    self.alert(title: "Oops", message: "There seems to be no restaurants available. Please choose another address");
                }
                else
                {
                    let viewController = PNPlaceOrderViewController(nibName: "PNPlaceOrderViewController", bundle: nil)
                    
//                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
                
            }, FailureBlock: { (error) in
                if let localError = error as? ErrorBaseClass{
//                    self.alert(title: "Oops", message: localError.localizedDescription)
                }else{
//                    self.alert(title: "Error", message: "Something went wrong")
                }
            })
            
        }) { (error) in
            if let localError = error as? ErrorBaseClass{
//                self.alert(title: "Oops", message: localError.localizedDescription)
            }else{
//                self.alert(title: "Error", message: "Something went wrong")
            }
        }

    }
    
}
