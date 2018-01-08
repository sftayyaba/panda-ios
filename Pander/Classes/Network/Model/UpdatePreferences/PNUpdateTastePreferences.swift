//
//  PNUpdateTastePreferences.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNUpdateTastePreferences: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNUpdateTastePreferencesCodeKey: String = " code "
	internal let kPNUpdateTastePreferencesCuisinesKey: String = " cuisines "


    // MARK: Properties
	public var code: Int?
	public var cuisines: [PNCuisines]?


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
		code = json[kPNUpdateTastePreferencesCodeKey].int
		cuisines = []
		if let items = json[kPNUpdateTastePreferencesCuisinesKey].array {
			for item in items {
				cuisines?.append(PNCuisines(json: item))
			}
		} else {
			cuisines = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kPNUpdateTastePreferencesCodeKey)
		}
		if cuisines?.count > 0 {
			var temp: [AnyObject] = []
			for item in cuisines! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kPNUpdateTastePreferencesCuisinesKey)
		}

        return dictionary
    }

}
