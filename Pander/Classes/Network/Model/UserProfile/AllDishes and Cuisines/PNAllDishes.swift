//
//  PNPNAllDishes.swift
//
//  Created by Shery on 20/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNAllDishes: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNPNAllDishesDishesKey: String = "dishes"


    // MARK: Properties
	public var dishes: [String]?


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
		dishes = []
		if let items = json[kPNPNAllDishesDishesKey].array {
			for item in items {
				if let tempValue = item.string {
				dishes?.append(tempValue)
				}
			}
		} else {
			dishes = nil
		}

    }


//    /**
//    Generates description of the object in the form of a NSDictionary.
//    - returns: A Key value pair containing all valid values in the object.
//    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if let count = dishes?.count{
//            if count > 0 {
//                dictionary.updateValue(dishes! as AnyObject, forKey: kPNPNAllDishesDishesKey)
//            }
//            
//        }
//
//        return dictionary
//    }
//
}
