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
    
    var numberofSectionHeaders = 3
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSectionHeaders
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 && isLocationSelected {
            return numberofLocations
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
        if indexPath.section == 0 && isLocationSelected {
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
//
            self.isLocationSelected = true

            self.reloadData()
        }
        
        cell.locationButton.isSelected = self.isLocationSelected
        return cell
    }
    
    //MARK: Section 0 Cells
    func tableView(_ tableView: UITableView, cellForAddLocationOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNAddLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNAddLocationTableViewCell") as? PNAddLocationTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForLocationsOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderLocationTableViewCell") as? PNPlaceOrderLocationTableViewCell)!
        
        let address = PNUserManager.sharedInstance.addresses![indexPath.row]
        cell.setContent(address: address)

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
            self.reloadData()
        }else if indexPath.section == 2{
            if let dish = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?[indexPath.row]{
                dish.isSelected = !dish.isSelected
                
                reloadData()
            }
        }
    }
}
