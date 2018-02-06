//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit

class PNBudgetTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Members
    var isBankofWest = false
    var isBankOfAmerica = false
    var isChase = false
    
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
        return 3
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
            if self.isBankOfAmerica {
                self.isBankOfAmerica = false
            }else {
                self.isBankOfAmerica = true
            }
            self.isBankofWest = false
            self.isChase = false
        }else if indexPath.row == 1 {
            if self.isChase {
                self.isChase = false
            }else {
                self.isChase = true
            }
            self.isBankOfAmerica = false
            self.isBankofWest = false
        }else if indexPath.row == 2 {
            if self.isBankofWest {
                self.isBankofWest = false
            }else {
                self.isBankofWest = true
            }
            self.isBankOfAmerica = false
            self.isChase = false
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
            self.isBankOfAmerica = false
        }else if indexPath.row == 1 {
            self.isChase = false
        }else if indexPath.row == 2 {
            self.isBankofWest = false
        }
        self.reloadData()
    }
    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: PNCurrentLocationTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNCurrentLocationTableViewCell", for: indexPath) as? PNCurrentLocationTableViewCell)!
        
        if indexPath.row == 0{
            return self.tableView(tableView, cellForBankOfAmerica: indexPath)
        }else if indexPath.row == 1 {
            return self.tableView(tableView, cellChaseCard: indexPath)
        }else if indexPath.row == 2 {
            return self.tableView(tableView, cellForBankOfWest: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, cellForBankOfAmerica indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNBankOfAmericaTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNBankOfAmericaTableViewCell", for: indexPath) as? PNBankOfAmericaTableViewCell)!
        
        cell.setContent(status: isBankOfAmerica)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForBankOfWest indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNBankOfWestTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNBankOfWestTableViewCell", for: indexPath) as? PNBankOfWestTableViewCell)!
        cell.setContent(status: isBankofWest)
        return cell
    }

    func tableView(_ tableView: UITableView, cellChaseCard indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNChaseCardTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNChaseCardTableViewCell", for: indexPath) as? PNChaseCardTableViewCell)!
        cell.setContent(status: isChase)
        return cell
    }
}

