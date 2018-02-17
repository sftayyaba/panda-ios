//
//  PNAllCuisines.swift
//
//  Created by Shery on 20/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNAllCuisines: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNAllCuisinesCuisinesKey: String = "cuisines"


    // MARK: Properties
	public var cuisines: [String]?


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
		cuisines = []
		if let items = json[kPNAllCuisinesCuisinesKey].array {
			for item in items {
				if let tempValue = item.string {
				cuisines?.append(tempValue)
				}
			}
		} else {
			cuisines = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if cuisines?.count > 0 {
//            dictionary.updateValue(cuisines!, forKey: kPNAllCuisinesCuisinesKey)
//        }
//
//        return dictionary
//    }

}
