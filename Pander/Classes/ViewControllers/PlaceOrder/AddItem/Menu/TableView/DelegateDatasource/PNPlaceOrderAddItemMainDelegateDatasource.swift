//
//  PNPlaceOrderDelegateDatasource.swift
//  Pander
//
//  Created by Shery on 03/02/2018.
//

import UIKit

class PNPlaceOrderAddItemMainDelegateDatasource: UITableView,UITableViewDelegate,UITableViewDataSource {
   
    var currentArray: [PNOrderDish]!
    var type: PNMenuTab!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       var currentList = [PNOrderDish]()
        
        if type == .main{
            if let arr = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.rawEntrees{
                currentList = arr
            }
        }else if type == .appetizer{
            if let arr = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.rawAppetizers{
                currentList = arr
            }
        }else if type == .drink{
            if let arr = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.rawDrinks{
                currentList = arr
            }
        }else if type == .dessert{
            if let arr = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.rawDesserts{
                currentList = arr
            }
        }
        
        currentArray = currentList

       return currentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dish = currentArray[indexPath.row]
        let isAdded = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.first(where: { (currentDish) -> Bool in
            return dish.id == currentDish.id
        }) != nil
    
        if isAdded{
            let cell = self.tableView(tableView, cellForAddedItemOptionAt: indexPath)
            cell.setContent(dish: dish)
            return cell

        }else{
            let cell = self.tableView(tableView, cellForAddItemOptionAt: indexPath)
            cell.setContent(dish: dish)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, cellForAddItemOptionAt indexPath: IndexPath) -> PNPlaceOrderMainAddItemTableViewCell {
        let cell: PNPlaceOrderMainAddItemTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNPlaceOrderMainAddItemTableViewCell") as? PNPlaceOrderMainAddItemTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForAddedItemOptionAt indexPath: IndexPath) -> PNMenuAddedDishTableViewCell {
        let cell: PNMenuAddedDishTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNMenuAddedDishTableViewCell") as? PNMenuAddedDishTableViewCell)!
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = currentArray[indexPath.row]
        let isAdded = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.first(where: { (currentDish) -> Bool in
            return dish.id == currentDish.id
        }) != nil
        
        if isAdded{
            PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order = PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.filter({ (currentDish) -> Bool in
                return dish.id != currentDish.id
            })
        }else{
            PNOrderManager.sharedInstance.generatedOrder?.recommendation?.order?.append(dish)
        }
        
        self.reloadData()
    }
}
