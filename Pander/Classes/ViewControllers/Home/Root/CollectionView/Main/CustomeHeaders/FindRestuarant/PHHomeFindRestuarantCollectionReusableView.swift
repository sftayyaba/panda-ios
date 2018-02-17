//
//  PHHomeCollectionReusableView.swift
//  Pander
//
//  Created by Shery on 31/01/2018.
//

import UIKit

class PHHomeFindRestuarantCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var labelGroupSizePerson: UILabel!
    @IBOutlet weak var labelPersonBudget: UILabel!
    @IBOutlet var arrowUpButton: UIButton!
    @IBOutlet var searchView: UIView!
    @IBOutlet var sepratorView: UIView!

    //MARK: Callbacks
    public var didMoveDownButtonCallback : (() -> Void)?
    public var didMoveUpButtonCallback : (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.arrowUpButton.isHidden = true
    }
    
    @IBAction func moveUpButtonTapped(_ sender: Any) {
        if let callBack = self.didMoveUpButtonCallback {
            callBack()
        }
        self.sepratorView.isHidden = false
        self.arrowUpButton.isHidden = true
        self.searchView.isHidden = false
    }
    
    @IBAction func moveDownButtonTapped(_ sender: Any) {
        if let callBack = self.didMoveDownButtonCallback {
            callBack()
        }
        self.sepratorView.isHidden = true
        self.arrowUpButton.isHidden = false
        self.searchView.isHidden = true
    }
    
    func setContent(){
        labelPersonBudget.text = "$\(PNUserManager.sharedInstance.budgetPerPerson)"
        labelGroupSizePerson.text = "\(PNUserManager.sharedInstance.groupSize) Person"
    }
}
