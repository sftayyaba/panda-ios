//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit
import MGSwipeTableCell

class PNLocationTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {
    
    //MARK: Members
    var addresses: [PNAddresses] = []

    var isCurrentLocation = false
    var isMomsHouse = false
    var isHome = false
    var isTravisField = false
    var isJeff = false
    
    //MARK: Callbacks
    public var didSelectAddressCallback : ((PNAddresses) -> Void)?

    public var didSelectEditAddressCallback : ((PNAddresses) -> Void)?
    public var didSelectRemoveAddressCallback : ((PNAddresses) -> Void)?
    public var didSelectSetAsDefaultAddressCallback : ((PNAddresses) -> Void)?

    
    override func awakeFromNib() {
        self.configureTableView()
    }
    
    // MARK: Private Methods
    // MARK: View
    private func configureTableView() {
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "PNLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "PNLocationTableViewCell")
    }
    
    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForResultsRowAt: indexPath)
    }
    
    //MARK: Delegates
    //MARK: MGSwipe delegate for buttons
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let indexPath = self.indexPath(for: cell)
    
        switch index {
        case 2:
            if let callBack = self.didSelectSetAsDefaultAddressCallback{
                callBack(self.addresses[indexPath!.row])
            }
        case 1:
            if let callBack = self.didSelectEditAddressCallback{
                callBack(self.addresses[indexPath!.row])
            }
        case 0:
            if let callBack = self.didSelectRemoveAddressCallback{
                callBack(self.addresses[indexPath!.row])
            }

        default:
            print("something pressed for item \(indexPath!.row)")
        }
        
        return true
        
    }
    
    //MARK: Rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 53
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(EMPayementHistoryTableViewConstants.kHeightForItemRow)
    }
        
    //MARK: Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = self.addresses[indexPath.row]
        address.isSelected = !address.isSelected

        var selectDefault = false
        
        if !address.isSelected{
            selectDefault = true
        }
        
        var selectedAddress = address;
        self.addresses = self.addresses.map { (currentAddress) -> PNAddresses in
            
            if (address.locationId != currentAddress.locationId){
                currentAddress.isSelected = false
            }
            
            if selectDefault && currentAddress.isDefault{
                currentAddress.isSelected = true;
                selectedAddress = currentAddress
            }
            
            return currentAddress
        }
        
        if let callback = self.didSelectAddressCallback{
            selectedAddress.isSelected = true
            callback(selectedAddress);
        }
        self.reloadData()

    }
    

    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.tableView(tableView, cellForCurrentLocation: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForCurrentLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNCurrentLocationTableViewCell", for: indexPath) as? PNCurrentLocationTableViewCell)!
        
        let address = self.addresses[indexPath.row]
        
        cell.setContent(address: address)

        cell.setSelected(address.isSelected, animated: false)

        cell.delegate = self
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForHomeLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNHomeLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNHomeLocationTableViewCell", for: indexPath) as? PNHomeLocationTableViewCell)!
        cell.setContent(status: isHome)
        return cell
    }

    func tableView(_ tableView: UITableView, cellForMomLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNMomLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNMomLocationTableViewCell", for: indexPath) as? PNMomLocationTableViewCell)!
        cell.setContent(status: isMomsHouse)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForFriendLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNFriendLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNFriendLocationTableViewCell", for: indexPath) as? PNFriendLocationTableViewCell)!
        cell.setContent(status: isJeff)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, cellForTravisFieldLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNTravisFieldTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNTravisFieldTableViewCell", for: indexPath) as? PNTravisFieldTableViewCell)!
        cell.setContent(status: isTravisField)
        return cell
    }
}

