//
//  userCuisinePreferences.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class userCuisinePreferences: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kuserCuisinePreferencesRatingKey: String = "rating"
	internal let kuserCuisinePreferencesNumOrdersKey: String = "num_orders"
	internal let kuserCuisinePreferencesCuisineKey: String = "cuisine"


    // MARK: Properties
	public var rating: Float?
	public var numOrders: Int?
	public var cuisine: String?


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
		rating = json[kuserCuisinePreferencesRatingKey].float
		numOrders = json[kuserCuisinePreferencesNumOrdersKey].int
		cuisine = json[kuserCuisinePreferencesCuisineKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if rating != nil {
            dictionary.updateValue(rating! as AnyObject, forKey: kuserCuisinePreferencesRatingKey)
		}
		if numOrders != nil {
            dictionary.updateValue(numOrders! as AnyObject, forKey: kuserCuisinePreferencesNumOrdersKey)
		}
		if cuisine != nil {
            dictionary.updateValue(cuisine! as AnyObject, forKey: kuserCuisinePreferencesCuisineKey)
		}

        return dictionary
    }

}
