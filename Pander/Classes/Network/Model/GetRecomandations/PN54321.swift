//
//  PN54321.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PN54321: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPN54321DishKey: String = " dish "
	internal let kPN54321ImageUrlKey: String = " image_url "
	internal let kPN54321CuisineKey: String = " cuisine "


    // MARK: Properties
	public var dish: String?
	public var imageUrl: String?
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
		dish = json[kPN54321DishKey].string
		imageUrl = json[kPN54321ImageUrlKey].string
		cuisine = json[kPN54321CuisineKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if dish != nil {
			dictionary.updateValue(dish!, forKey: kPN54321DishKey)
		}
		if imageUrl != nil {
			dictionary.updateValue(imageUrl!, forKey: kPN54321ImageUrlKey)
		}
		if cuisine != nil {
			dictionary.updateValue(cuisine!, forKey: kPN54321CuisineKey)
		}

        return dictionary
    }

}
