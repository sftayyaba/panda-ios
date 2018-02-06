//
//  FindRestuarantCollectionViewCell.swift
//  Pander
//
//  Created by Shery on 30/01/2018.
//

import UIKit

class FindRestuarantCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public var didLocationButtonCallback : (() -> Void)?
    public var didDishesButtonCallback : (() -> Void)?
    public var didBudgetButtonCallback : (() -> Void)?
    public var didPeopleButtonCallback : (() -> Void)?
    public var didDeliveryButtonCallback : (() -> Void)?
    public var didFindRestaurentButtonCallback : (() -> Void)?

    
    @IBAction func locationButtonPressed(_ sender: Any) {
        if let callback = didLocationButtonCallback{
            callback()
        }
    }
    
    @IBAction func dishesButtonPressed(_ sender: Any) {
        if let callback = didDishesButtonCallback{
            callback()
        }
    }
    
    @IBAction func budgetButtonPressed(_ sender: Any) {
        if let callback = didBudgetButtonCallback{
            callback()
        }

    }
    
    @IBAction func peopleButtonPressed(_ sender: Any) {
        if let callback = didPeopleButtonCallback{
            callback()
        }
    }
    
    @IBAction func deliverASAPButtonPressed(_ sender: Any) {
        if let callback = didDeliveryButtonCallback{
            callback()
        }

    }
    
    @IBAction func findRestaurentButtonPressed(_ sender: Any) {
        if let callback = didFindRestaurentButtonCallback{
            callback()
        }
        
    }

}
