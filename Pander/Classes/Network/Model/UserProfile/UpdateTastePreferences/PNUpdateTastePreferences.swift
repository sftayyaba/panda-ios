//
//  PNUpdateTastePreferences.swift
//
//  Created by $hery on 08/02/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNUpdateTastePreferences: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNUpdateTastePreferencesAdventureKey: String = "adventure"
	internal let kPNUpdateTastePreferencesCodeKey: String = "code"
	internal let kPNUpdateTastePreferencesCuisinesKey: String = "cuisines"
	internal let kPNUpdateTastePreferencesUserClusterKey: String = "user_cluster"


    // MARK: Properties
	public var adventure: Int?
	public var code: Int?
	public var cuisines: [userCuisinePreferences]?
	public var userCluster: String?


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
		adventure = json[kPNUpdateTastePreferencesAdventureKey].int
		code = json[kPNUpdateTastePreferencesCodeKey].int
		cuisines = []
		if let items = json[kPNUpdateTastePreferencesCuisinesKey].array {
			for item in items {
				cuisines?.append(userCuisinePreferences(json: item))
			}
		} else {
			cuisines = nil
		}
		userCluster = json[kPNUpdateTastePreferencesUserClusterKey].string

    }
}
