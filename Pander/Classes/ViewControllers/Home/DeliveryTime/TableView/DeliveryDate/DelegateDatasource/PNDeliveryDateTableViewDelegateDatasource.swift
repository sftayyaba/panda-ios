//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit

class PNDeliveryDateTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Members
    var isCurrentLocation = false
    var isMomsHouse = false
    var isHome = false
    var isTravisField = false
    var isJeff = false
    
    var dateArray = [String]()
    var dateState = [Bool]()

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
        
        self.register(UINib(nibName: "PNDeliveryDateTableViewCell", bundle: nil), forCellReuseIdentifier: "PNDeliveryDateTableViewCell")
    }
    
    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dateArray.count
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
    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
        
            return self.tableView(tableView, cellForDeliveryDate: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForDeliveryDate indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNDeliveryDateTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNDeliveryDateTableViewCell", for: indexPath) as? PNDeliveryDateTableViewCell)!
            cell.setContent(status: self.dateState[indexPath.row], title: self.dateArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<self.dateState.count {
            if indexPath.row == i {
                self.dateState[i] = true
            }else {
                self.dateState[i] = false
            }
        }
        self.reloadData()
    }
    
}

