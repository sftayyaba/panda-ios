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
    
    
    var numberofLocations = 5
    
    var numberofSectionHeaders = 5
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberofSectionHeaders
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 && isLocationSelected {
            return numberofLocations
        }else {
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
            return 70
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && isLocationSelected {
            if indexPath.row == 0 {
                return self.tableView(tableView, cellForCurrentLocationOptionAt: indexPath)
            }else if indexPath.row == (numberofLocations - 1) {
                return self.tableView(tableView, cellForAddLocationOptionAt: indexPath)
            }else {
                return self.tableView(tableView, cellForLocationsOptionAt: indexPath)
            }
        }else {
            return self.tableView(tableView, cellForPaymentOptionAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return self.tableView(tableView, headerForLocationOptionAt: section)
        }else if section == 1{
            return self.tableView(tableView, headerForAddItemsOptionAt: section)
        }else {
            return self.tableView(tableView, headerForItemsOptionAt: section)
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
        
        return cell
    }

    func tableView(_ tableView: UITableView, cellForCurrentLocationOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderCurrentLocationTableViewCell") as? PNPlaceOrderCurrentLocationTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForPaymentOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderPaymentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderPaymentTableViewCell") as? PNPlaceOrderPaymentTableViewCell)!
        
        return cell
    }
    
    //MARK: Section Headers
    func tableView(_ tableView: UITableView, headerForAddItemsOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNPlaceOrderImageSliderTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderImageSliderTableViewCell") as? PNPlaceOrderImageSliderTableViewCell)!
        
        cell.didAddItemButtonCallback = self.didAddItemButtonCallback;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, headerForItemsOptionAt section: Int) -> UITableViewCell {
        
        let cell: PNPlaceOrderItemsTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderItemsTableViewCell") as? PNPlaceOrderItemsTableViewCell)!
        
        return cell
    }
}
