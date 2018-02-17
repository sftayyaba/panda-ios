//
//  PNGetCardsBaseClass.swift
//
//  Created by Shery on 10/02/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNGetCardsBaseClass: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNGetCardsBaseClassCardsKey: String = "cards"
	internal let kPNGetCardsBaseClassCodeKey: String = "code"


    // MARK: Properties
	public var cards: [PNCards]?
	public var code: Int?


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
		cards = []
		if let items = json[kPNGetCardsBaseClassCardsKey].array {
			for item in items {
				cards?.append(PNCards(json: item))
			}
		} else {
			cards = nil
		}
		code = json[kPNGetCardsBaseClassCodeKey].int

    }
}
