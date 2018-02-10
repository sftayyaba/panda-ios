//
//  PNCards.swift
//
//  Created by Shery on 10/02/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNCards: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNCardsExpMonthKey: String = "exp_month"
	internal let kPNCardsTypeKey: String = "type"
	internal let kPNCardsDefaultKey: String = "default"
	internal let kPNCardsExpYearKey: String = "exp_year"
	internal let kPNCardsLabelKey: String = "label"
	internal let kPNCardsLastUsedKey: String = "last_used"
	internal let kPNCardsCcIdKey: String = "cc_id"
	internal let kPNCardsLastFourKey: String = "last_four"

    // MARK: Properties
    public var isSelected: Bool = false
    public var isDefault: Bool = false
    public var nick: String?

	public var expMonth: Int?
	public var type: String?
	public var cardDefault: Bool = false
	public var expYear: Int?
	public var label: String?
	public var lastUsed: String?
	public var ccId: String?
	public var lastFour: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		expMonth = json[kPNCardsExpMonthKey].int
		type = json[kPNCardsTypeKey].string
		cardDefault = json[kPNCardsDefaultKey].boolValue
		expYear = json[kPNCardsExpYearKey].int
		label = json[kPNCardsLabelKey].string
		lastUsed = json[kPNCardsLastUsedKey].string
		ccId = json[kPNCardsCcIdKey].string
		lastFour = json[kPNCardsLastFourKey].string
    }
}
