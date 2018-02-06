//
//  PNPlaceOrderDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNPlaceOrderAddItemMainDelegateDatasource: UITableView,UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 53
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return self.tableView(tableView, cellForAddItemOptionAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForAddItemOptionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PNPlaceOrderMainAddItemTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderMainAddItemTableViewCell") as? PNPlaceOrderMainAddItemTableViewCell)!
        
        return cell
    }
    
}
