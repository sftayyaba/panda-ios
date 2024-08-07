//
//  PNCodeResponse.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

enum PNApiResponseCodes: Int{
    case successResponse = 0
    case errorResponse = -1
}

public class PNCodeResponse: NSObject {

    
    // MARK: Declaration for string constants to be used to decode and also serialize.
	public static let kPNCodeResponseCodeKey: String = " code "


    // MARK: Properties
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
        code = json[PNCodeResponse.kPNCodeResponseCodeKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
            dictionary.updateValue(code! as AnyObject, forKey: PNCodeResponse.kPNCodeResponseCodeKey)
		}

        return dictionary
    }

}
