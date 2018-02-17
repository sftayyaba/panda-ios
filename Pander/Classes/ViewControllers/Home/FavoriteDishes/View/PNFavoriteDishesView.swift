//
//  PNLogin.swift
//  Pander
//
//  Created by Shery on 26/11/2017.
//

import UIKit

class PNFavoriteDishesView: UIView {

    @IBOutlet var cuisineTextField: UITextField!
    @IBOutlet var nextButton: UIButton!

    var textChangedCallback: ((String)->())?
    
    override func awakeFromNib() {
    }
}
