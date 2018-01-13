//
//  PNCreateGuestAccount.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PNCreateGuestAccount: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPNCreateGuestAccountCodeKey: String = "code"
	internal let kPNCreateGuestAccountUserIdKey: String = "user_id"
	internal let kPNCreateGuestAccountRefreshTokenPanderKey: String = "refresh_token_pander"
	internal let kPNCreateGuestAccountAccessTokenPanderKey: String = "access_token_pander"


    // MARK: Properties
	public var code: Int?
	public var userId: String?
	public var refreshTokenPander: String?
	public var accessTokenPander: String?


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
		code = json[kPNCreateGuestAccountCodeKey].int
		userId = json[kPNCreateGuestAccountUserIdKey].string
		refreshTokenPander = json[kPNCreateGuestAccountRefreshTokenPanderKey].string
		accessTokenPander = json[kPNCreateGuestAccountAccessTokenPanderKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
            dictionary.updateValue(code! as AnyObject, forKey: kPNCreateGuestAccountCodeKey)
		}
		if userId != nil {
            dictionary.updateValue(userId! as AnyObject, forKey: kPNCreateGuestAccountUserIdKey)
		}
		if refreshTokenPander != nil {
            dictionary.updateValue(refreshTokenPander! as AnyObject, forKey: kPNCreateGuestAccountRefreshTokenPanderKey)
		}
		if accessTokenPander != nil {
            dictionary.updateValue(accessTokenPander! as AnyObject, forKey: kPNCreateGuestAccountAccessTokenPanderKey)
		}

        return dictionary
    }

}
