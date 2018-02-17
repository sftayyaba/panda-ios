//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit

enum PNDeliveryTableViewType{
    case time
    case date
}
class PNDeliveryDateTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Members
    var type : PNDeliveryTableViewType = .date
    var isCurrentLocation = false
    var isMomsHouse = false
    var isHome = false
    var isTravisField = false
    var isJeff = false
    
    var dateArray = [String]()

    var timesArray = [String]()
    


    //MARK: Callbacks
    public var didSelectDateCallback : (() -> Void)?
    public var didSelectTimeCallback : (() -> Void)?

    
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
        return self.type == .date ? self.dateArray.count : self.timesArray.count
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
        
        let title = type == .date ? self.dateArray[indexPath.row] : self.timesArray[indexPath.row]
        
        var state = false

        state = type == .date ? PNUserManager.sharedInstance.selectedDate == title : PNUserManager.sharedInstance.selectedTime == title
        cell.setContent(status: state , title:title )

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    
        if type == .date {
            if PNUserManager.sharedInstance.selectedDate != self.dateArray[indexPath.row]{
                PNUserManager.sharedInstance.selectedDate = self.dateArray[indexPath.row]
                
                PNUserManager.sharedInstance.selectedTime = ""
                if let callback = self.didSelectDateCallback{
                    callback()
                }
            }
        }else {

            PNUserManager.sharedInstance.selectedTime = self.timesArray[indexPath.row]
            if let callback = self.didSelectTimeCallback{
                callback()
            }
        }

        self.reloadData()
    }
    
}

