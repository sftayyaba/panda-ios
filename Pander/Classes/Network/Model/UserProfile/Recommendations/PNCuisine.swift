//
//  PN12345.swift
//
//  Created by Shery on 12/01/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNCuisine: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPN12345ImageUrlKey: String = "image_url"
	internal let kPN12345CuisineKey: String = "cuisine"
    internal let kPN12345DishKey: String = "dish"



    // MARK: Properties
	public var imageUrl: String?
	public var cuisine: String?
    public var dish: String?


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
		imageUrl = json[kPN12345ImageUrlKey].string
		cuisine = json[kPN12345CuisineKey].string
        dish = json[kPN12345DishKey].string
    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if imageUrl != nil {
//            dictionary.updateValue(imageUrl!, forKey: kPN12345ImageUrlKey)
//        }
//        if cuisine != nil {
//            dictionary.updateValue(cuisine!, forKey: kPN12345CuisineKey)
//        }
//
//        return dictionary
//    }

}
