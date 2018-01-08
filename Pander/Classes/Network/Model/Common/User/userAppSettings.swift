//
//  userAppSettings.swift
//
//  Created by Shery on 26/11/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class userAppSettings: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kuserAppSettingsVeganKey: String = " vegan "
	internal let kuserAppSettingsAlcoholKey: String = " alcohol "
	internal let kuserAppSettingsSpecialNotifKey: String = " special_notif "
	internal let kuserAppSettingsGroupSizeKey: String = " group_size "
	internal let kuserAppSettingsExpandKey: String = " expand "
	internal let kuserAppSettingsVegetarianKey: String = " vegetarian "
	internal let kuserAppSettingsDrinksKey: String = " drinks "
	internal let kuserAppSettingsConfirmKey: String = " confirm "
	internal let kuserAppSettingsTipKey: String = " tip "
	internal let kuserAppSettingsPersonalNotifKey: String = " personal_notif "
	internal let kuserAppSettingsPeanutsKey: String = " peanuts "
	internal let kuserAppSettingsDebugKey: String = " debug "
	internal let kuserAppSettingsNutsKey: String = " nuts "
	internal let kuserAppSettingsDessertKey: String = " dessert "


    // MARK: Properties
	public var vegan: Bool = false
	public var alcohol: Bool = false
	public var specialNotif: Bool = false
	public var groupSize: Int?
	public var expand: Bool = false
	public var vegetarian: Bool = false
	public var drinks: Bool = false
	public var confirm: Bool = false
	public var tip: Int?
	public var personalNotif: Bool = false
	public var peanuts: Bool = false
	public var debug: Bool = false
	public var nuts: Bool = false
	public var dessert: Bool = false


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
		vegan = json[kuserAppSettingsVeganKey].boolValue
		alcohol = json[kuserAppSettingsAlcoholKey].boolValue
		specialNotif = json[kuserAppSettingsSpecialNotifKey].boolValue
		groupSize = json[kuserAppSettingsGroupSizeKey].int
		expand = json[kuserAppSettingsExpandKey].boolValue
		vegetarian = json[kuserAppSettingsVegetarianKey].boolValue
		drinks = json[kuserAppSettingsDrinksKey].boolValue
		confirm = json[kuserAppSettingsConfirmKey].boolValue
		tip = json[kuserAppSettingsTipKey].int
		personalNotif = json[kuserAppSettingsPersonalNotifKey].boolValue
		peanuts = json[kuserAppSettingsPeanutsKey].boolValue
		debug = json[kuserAppSettingsDebugKey].boolValue
		nuts = json[kuserAppSettingsNutsKey].boolValue
		dessert = json[kuserAppSettingsDessertKey].boolValue

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
        dictionary.updateValue(vegan as AnyObject, forKey: kuserAppSettingsVeganKey)
        dictionary.updateValue(alcohol as AnyObject, forKey: kuserAppSettingsAlcoholKey)
        dictionary.updateValue(specialNotif as AnyObject, forKey: kuserAppSettingsSpecialNotifKey)
		if groupSize != nil {
            dictionary.updateValue(groupSize! as AnyObject, forKey: kuserAppSettingsGroupSizeKey)
		}
        dictionary.updateValue(expand as AnyObject, forKey: kuserAppSettingsExpandKey)
        dictionary.updateValue(vegetarian as AnyObject, forKey: kuserAppSettingsVegetarianKey)
        dictionary.updateValue(drinks as AnyObject, forKey: kuserAppSettingsDrinksKey)
        dictionary.updateValue(confirm as AnyObject, forKey: kuserAppSettingsConfirmKey)
		if tip != nil {
            dictionary.updateValue(tip! as AnyObject, forKey: kuserAppSettingsTipKey)
		}
        dictionary.updateValue(personalNotif as AnyObject, forKey: kuserAppSettingsPersonalNotifKey)
        dictionary.updateValue(peanuts as AnyObject, forKey: kuserAppSettingsPeanutsKey)
        dictionary.updateValue(debug as AnyObject, forKey: kuserAppSettingsDebugKey)
        dictionary.updateValue(nuts as AnyObject, forKey: kuserAppSettingsNutsKey)
        dictionary.updateValue(dessert as AnyObject, forKey: kuserAppSettingsDessertKey)

        return dictionary
    }

}
