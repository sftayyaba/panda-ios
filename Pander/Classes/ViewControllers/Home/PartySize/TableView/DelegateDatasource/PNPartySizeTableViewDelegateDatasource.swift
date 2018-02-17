//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit

class PNPartySizeTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate {
    //MARK: Members
    
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
        
        self.register(UINib(nibName: "PNPartySizeTableViewCell", bundle: nil), forCellReuseIdentifier: "PNPartySizeTableViewCell")
    }
    
    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForResultsRowAt: indexPath)
    }
    
    //MARK: Delegates
    //MARK: Rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(EMPayementHistoryTableViewConstants.kHeightForItemRow)
    }
        
    //MARK: Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.didSelectFriendCallback != nil {
            self.didSelectFriendCallback!()
        }
    }
    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPartySizeTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPartySizeTableViewCell", for: indexPath) as? PNPartySizeTableViewCell)!
        return cell
    }
}

