//
//  PNDishesByZip.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNDishesByZip: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNDishesByZip54321Key: String = " 54321 "
	internal let kPNDishesByZip12345Key: String = " 12345 "


    // MARK: Properties
	public var 54321: [PN54321]?
	public var 12345: [PN12345]?


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
		54321 = []
		if let items = json[kPNDishesByZip54321Key].array {
			for item in items {
				54321?.append(PN54321(json: item))
			}
		} else {
			54321 = nil
		}
		12345 = []
		if let items = json[kPNDishesByZip12345Key].array {
			for item in items {
				12345?.append(PN12345(json: item))
			}
		} else {
			12345 = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if 54321?.count > 0 {
			var temp: [AnyObject] = []
			for item in 54321! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kPNDishesByZip54321Key)
		}
		if 12345?.count > 0 {
			var temp: [AnyObject] = []
			for item in 12345! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kPNDishesByZip12345Key)
		}

        return dictionary
    }

}
