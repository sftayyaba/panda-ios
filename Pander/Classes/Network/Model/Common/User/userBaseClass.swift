//
//  userBaseClass.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class userBaseClass: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kuserBaseClassEmailKey: String = " email "
	internal let kuserBaseClassDdcTokenExpiresKey: String = " ddc_token_expires "
	internal let kuserBaseClassRefreshTokenPanderKey: String = " refresh_token_pander "
	internal let kuserBaseClassIsFirstSignupKey: String = " is_first_signup "
	internal let kuserBaseClassDdcRefreshTokenKey: String = " ddc_refresh_token "
	internal let kuserBaseClassCuisinePreferencesKey: String = " cuisine_preferences "
	internal let kuserBaseClassLastNameKey: String = " last_name "
	internal let kuserBaseClassAdventurousnessKey: String = " adventurousness "
	internal let kuserBaseClassDdcAccessTokenKey: String = " ddc_access_token "
	internal let kuserBaseClassDdcCustomerIdKey: String = " ddc_customer_id "
	internal let kuserBaseClassAccessTokenPanderKey: String = " access_token_pander "
	internal let kuserBaseClassFirstNameKey: String = " first_name "
	internal let kuserBaseClassAppSettingsKey: String = " app_settings "


    // MARK: Properties
	public var email: String?
	public var ddcTokenExpires: Int?
	public var refreshTokenPander: String?
	public var isFirstSignup: Bool = false
	public var ddcRefreshToken: String?
	public var cuisinePreferences: [userCuisinePreferences]?
	public var lastName: String?
	public var adventurousness: Int?
	public var ddcAccessToken: String?
	public var ddcCustomerId: Int?
	public var accessTokenPander: String?
	public var firstName: String?
	public var appSettings: userAppSettings?


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
		email = json[kuserBaseClassEmailKey].string
		ddcTokenExpires = json[kuserBaseClassDdcTokenExpiresKey].int
		refreshTokenPander = json[kuserBaseClassRefreshTokenPanderKey].string
		isFirstSignup = json[kuserBaseClassIsFirstSignupKey].boolValue
		ddcRefreshToken = json[kuserBaseClassDdcRefreshTokenKey].string
		cuisinePreferences = []
		if let items = json[kuserBaseClassCuisinePreferencesKey].array {
			for item in items {
				cuisinePreferences?.append(userCuisinePreferences(json: item))
			}
		} else {
			cuisinePreferences = nil
		}
		lastName = json[kuserBaseClassLastNameKey].string
		adventurousness = json[kuserBaseClassAdventurousnessKey].int
		ddcAccessToken = json[kuserBaseClassDdcAccessTokenKey].string
		ddcCustomerId = json[kuserBaseClassDdcCustomerIdKey].int
		accessTokenPander = json[kuserBaseClassAccessTokenPanderKey].string
		firstName = json[kuserBaseClassFirstNameKey].string
		appSettings = userAppSettings(json: json[kuserBaseClassAppSettingsKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if email != nil {
            dictionary.updateValue(email! as AnyObject, forKey: kuserBaseClassEmailKey)
		}
		if ddcTokenExpires != nil {
            dictionary.updateValue(ddcTokenExpires! as AnyObject, forKey: kuserBaseClassDdcTokenExpiresKey)
		}
		if refreshTokenPander != nil {
            dictionary.updateValue(refreshTokenPander! as AnyObject, forKey: kuserBaseClassRefreshTokenPanderKey)
		}
        dictionary.updateValue(isFirstSignup as AnyObject, forKey: kuserBaseClassIsFirstSignupKey)
		if ddcRefreshToken != nil {
            dictionary.updateValue(ddcRefreshToken! as AnyObject, forKey: kuserBaseClassDdcRefreshTokenKey)
		}
		if (cuisinePreferences?.count)! > 0 {
			var temp: [AnyObject] = []
			for item in cuisinePreferences! {
                temp.append(item.dictionaryRepresentation() as AnyObject)
			}
            dictionary.updateValue(temp as AnyObject, forKey: kuserBaseClassCuisinePreferencesKey)
		}
		if lastName != nil {
            dictionary.updateValue(lastName! as AnyObject, forKey: kuserBaseClassLastNameKey)
		}
		if adventurousness != nil {
            dictionary.updateValue(adventurousness! as AnyObject, forKey: kuserBaseClassAdventurousnessKey)
		}
		if ddcAccessToken != nil {
            dictionary.updateValue(ddcAccessToken! as AnyObject, forKey: kuserBaseClassDdcAccessTokenKey)
		}
		if ddcCustomerId != nil {
            dictionary.updateValue(ddcCustomerId! as AnyObject, forKey: kuserBaseClassDdcCustomerIdKey)
		}
		if accessTokenPander != nil {
            dictionary.updateValue(accessTokenPander! as AnyObject, forKey: kuserBaseClassAccessTokenPanderKey)
		}
		if firstName != nil {
            dictionary.updateValue(firstName! as AnyObject, forKey: kuserBaseClassFirstNameKey)
		}
		if appSettings != nil {
            dictionary.updateValue(appSettings!.dictionaryRepresentation() as AnyObject, forKey: kuserBaseClassAppSettingsKey)
		}

        return dictionary
    }

}
