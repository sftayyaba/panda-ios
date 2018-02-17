//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit

class PNDeliveryTimeTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Members
    var isCurrentLocation = false
    var isMomsHouse = false
    var isHome = false
    var isTravisField = false
    var isJeff = false
    
    //MARK: Callbacks
    public var didSelectFriendCallback : (() -> Void)?
    
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForResultsRowAt: indexPath)
    }
    
    //MARK: Delegates
    //MARK: Rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 53
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(EMPayementHistoryTableViewConstants.kHeightForItemRow)
    }
        
    //MARK: Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            if self.isCurrentLocation {
                self.isCurrentLocation = false
            }else {
                self.isCurrentLocation = true
            }
            self.isMomsHouse = false
            self.isHome = false
            self.isTravisField = false
            self.isJeff = false
        }else if indexPath.row == 1 {
            if self.isMomsHouse {
                self.isMomsHouse = false
            }else {
                self.isMomsHouse = true
            }
            self.isCurrentLocation = false
            self.isHome = false
            self.isTravisField = false
            self.isJeff = false
        }else if indexPath.row == 2 {
            if self.isJeff {
                self.isJeff = false
            }else {
                self.isJeff = true
            }
            self.isCurrentLocation = false
            self.isMomsHouse = false
            self.isHome = false
            self.isTravisField = false
        }else if indexPath.row == 3 {
            if self.isHome {
                self.isHome = false
            }else {
                self.isHome = true
            }
            self.isCurrentLocation = false
            self.isMomsHouse = false
            self.isTravisField = false
            self.isJeff = false
        }else {
            if self.isTravisField {
                self.isTravisField = false
            }else {
                self.isTravisField = true
            }
            self.isCurrentLocation = false
            self.isMomsHouse = false
            self.isHome = false
            self.isJeff = false
        }
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        self.isCurrentLocation = false
//        self.isMomsHouse = false
//        self.isHome = false
//        self.isTravisField = false
//        self.isJeff = false
        
        if indexPath.row == 0 {
            self.isCurrentLocation = false
        }else if indexPath.row == 1 {
            self.isMomsHouse = false
        }else if indexPath.row == 2 {
            self.isJeff = false
        }else if indexPath.row == 3 {
            self.isHome = false
        }else {
            self.isTravisField = false
        }
        self.reloadData()
    }
    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: PNCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNCurrentLocationTableViewCell", for: indexPath) as? PNCurrentLocationTableViewCell)!
        
        if indexPath.row == 0{
            return self.tableView(tableView, cellForCurrentLocation: indexPath)
        }else if indexPath.row == 1 {
            return self.tableView(tableView, cellForMomLocation: indexPath)
        }else if indexPath.row == 2 {
            return self.tableView(tableView, cellForFriendLocation: indexPath)
        }else if indexPath.row == 3 {
            return self.tableView(tableView, cellForHomeLocation: indexPath)
        }else if indexPath.row == 4 {
            return self.tableView(tableView, cellForTravisFieldLocation: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, cellForCurrentLocation indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNCurrentLocationTableViewCell", for: indexPath) as? PNCurrentLocationTableViewCell)!
        
        cell.setContent(status: isCurrentLocation)
        cell.setSelected(isCurrentLocation, animated: false)
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

