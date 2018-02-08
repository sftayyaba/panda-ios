//
//  ErrorBaseClass.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ErrorBaseClass: NSObject, Error {

    public var localizedDescription: String
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kErrorBaseClassCodeKey: String = "code"

    internal let kErrorBaseClassErrorKey: String = "error"

    internal let kErrorBaseClassDevMsgKey: String = "dev_msg"
	internal let kErrorBaseClassUserMsgKey: String = "user_msg"


    // MARK: Properties
	public var code: Int?
    public var ddcCode: String?
	public var devMsg: String?
	public var userMsg: String?


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
		code = json[kErrorBaseClassCodeKey].int
        ddcCode = json[kErrorBaseClassCodeKey].string
        
        if let dev_msg = json[kErrorBaseClassErrorKey][kErrorBaseClassDevMsgKey].string{
            devMsg = dev_msg
        }else if let dev_msg = json[kErrorBaseClassDevMsgKey].string{
            devMsg = dev_msg
        }
        
        if let user_msg = json[kErrorBaseClassErrorKey][kErrorBaseClassUserMsgKey].string{
            userMsg = user_msg
        }else if let user_msg = json[kErrorBaseClassUserMsgKey].string{
            userMsg = user_msg
        }
        
        localizedDescription = userMsg!
    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
            dictionary.updateValue(code! as AnyObject, forKey: kErrorBaseClassCodeKey)
		}
		if devMsg != nil {
            dictionary.updateValue(devMsg! as AnyObject, forKey: kErrorBaseClassDevMsgKey)
		}
		if userMsg != nil {
            dictionary.updateValue(userMsg! as AnyObject, forKey: kErrorBaseClassUserMsgKey)
		}

        return dictionary
    }

}
