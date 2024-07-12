//
//  PNGetRecomendations.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNGetRecomendations: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNGetRecomendationsCodeKey: String = " code "
	internal let kPNGetRecomendationsDeliveryRecsKey: String = " delivery_recs "


    // MARK: Properties
	public var code: Int?
	public var deliveryRecs: PNDeliveryRecs?


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
		code = json[kPNGetRecomendationsCodeKey].int
		deliveryRecs = PNDeliveryRecs(json: json[kPNGetRecomendationsDeliveryRecsKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kPNGetRecomendationsCodeKey)
		}
		if deliveryRecs != nil {
			dictionary.updateValue(deliveryRecs!.dictionaryRepresentation(), forKey: kPNGetRecomendationsDeliveryRecsKey)
		}

        return dictionary
    }

}
