//
//  PNRecommendationsModel.swift
//
//  Created by Shery on 12/01/2018
//  Copyright (c) $hery. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNRecommendationsModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNRecommendationsModelDeliveryRecsKey: String = "delivery_recs"
	internal let kPNRecommendationsModelCodeKey: String = "code"


    // MARK: Properties
	public var deliveryRecs: PNDeliveryRecs?
	public var code: Int?


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
		deliveryRecs = PNDeliveryRecs(json: json[kPNRecommendationsModelDeliveryRecsKey])
		code = json[kPNRecommendationsModelCodeKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if deliveryRecs != nil {
//            dictionary.updateValue(deliveryRecs!.dictionaryRepresentation(), forKey: kPNRecommendationsModelDeliveryRecsKey)
//        }
//        if code != nil {
//            dictionary.updateValue(code!, forKey: kPNRecommendationsModelCodeKey)
//        }
//
//        return dictionary
//    }

}
