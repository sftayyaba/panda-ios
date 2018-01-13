//
//  PNDeliveryRecs.swift
//
//  Created by Shery on 12/01/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNDeliveryRecs: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNDeliveryRecsDishesByZipKey: String = "dishes_by_zip"
	internal let kPNDeliveryRecsCuisinesByZipKey: String = "cuisines_by_zip"


    // MARK: Properties
	public var dishesByZip: JSON?
	public var cuisinesByZip: JSON?


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
		dishesByZip = json[kPNDeliveryRecsDishesByZipKey]
		cuisinesByZip = json[kPNDeliveryRecsCuisinesByZipKey]

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if dishesByZip != nil {
//            dictionary.updateValue(dishesByZip!.dictionaryRepresentation(), forKey: kPNDeliveryRecsDishesByZipKey)
//        }
//        if cuisinesByZip != nil {
//            dictionary.updateValue(cuisinesByZip!.dictionaryRepresentation(), forKey: kPNDeliveryRecsCuisinesByZipKey)
//        }
//
//        return dictionary
//    }

}
