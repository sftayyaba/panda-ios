//
//  PNPA.swift
//  Pander
//
//  Created by Shery on 17/01/2018.
//

import Foundation
import UIKit
import MGSwipeTableCell

class PNBudgetTableViewDelegateDatasource: UITableView, UITableViewDataSource, UITableViewDelegate , MGSwipeTableCellDelegate {
    
    //MARK: Members
    var isBankofWest = false
    var isBankOfAmerica = false
    var isChase = false
    var cardsArray = [PNCards]()
    
    //MARK: Callbacks
    public var didSelectCardCallback : ((PNCards) -> Void)?

    public var didSelectEditCardCallback : ((PNCards) -> Void)?
    public var didSelectRemoveCardCallback : ((PNCards) -> Void)?
    public var didSelectSetAsDefaultCardCallback : ((PNCards) -> Void)?

    
    
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
        return cardsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForResultsRowAt: indexPath)
    }
    
    //MARK: Delegates
    //MARK: MGSwipe delegate for buttons
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let indexPath = self.indexPath(for: cell)
        
        switch index {
        case 1:
            if let callBack = self.didSelectSetAsDefaultCardCallback{
                callBack(self.cardsArray[indexPath!.row])
            }
        case 0:
            if let callBack = self.didSelectRemoveCardCallback{
                callBack(self.cardsArray[indexPath!.row])
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
        let card = self.cardsArray[indexPath.row]
        card.isSelected = !card.isSelected
        
        var selectDefault = false
        
        if !card.isSelected{
            selectDefault = true
        }
        
        var selectedCard = card;
        self.cardsArray = self.cardsArray.map { (currentCard) -> PNCards in
            
            if (card.ccId != currentCard.ccId){
                currentCard.isSelected = false
            }
            
            if selectDefault && currentCard.isDefault{
                currentCard.isSelected = true;
                selectedCard = currentCard
            }
            
            return currentCard
        }
        
        if let callback = self.didSelectCardCallback{
            selectedCard.isSelected = true;
            callback(selectedCard);
        }
        self.reloadData()
        
    }
    
    //MARK: Cells
    func tableView(_ tableView: UITableView, cellForResultsRowAt indexPath: IndexPath) -> UITableViewCell {
            return self.tableView(tableView, cellForBankOfAmerica: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForBankOfAmerica indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PNBankOfAmericaTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "PNBankOfAmericaTableViewCell", for: indexPath) as? PNBankOfAmericaTableViewCell)!
        
        let card = self.cardsArray[indexPath.row]
        cell.setContent(card: card)
        cell.delegate = self
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

