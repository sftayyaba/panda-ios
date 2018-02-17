//
//  PNAddresses.swift
//
//  Created by Abdul Sami on 10/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNAddresses: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let numOfRests = "num_of_rests"
    static let pickup = "pickup"
    static let timeMerchantChecked = "time_merchant_checked"
    static let dateLastUsed = "date_last_used"
    static let bad = "bad"
    static let locationId = "location_id"
    static let latitude = "latitude"
    static let geoService = "geo_service"
    static let phone = "phone"
    static let unitNumber = "unit_number"
    static let zipCode = "zip_code"
    static let giftBasket = "gift_basket"
    static let longitude = "longitude"
    static let postalCode = "postal_code"
    static let instructions = "instructions"
    static let city = "city"
    static let delivery = "delivery"
    static let street = "street"
    static let caterer = "caterer"
    static let florist = "florist"
    static let timeUpdated = "time_updated"
    static let label = "label"
    static let defaultValue = "default"
    static let editableFields = "editable_fields"
    static let zipCode9 = "zip_code_9"
  }

  // MARK: Properties
    public var isSelected: Bool = false
    public var isDefault: Bool = false
    public var nick: String?
    
    public var state: String?
  public var numOfRests: Int?
  public var pickup: String?
  public var timeMerchantChecked: String?
  public var dateLastUsed: String?
  public var bad: Int?
  public var locationId: Int?
  public var latitude: Float?
  public var geoService: String?
  public var phone: String?
  public var unitNumber: String?
  public var zipCode: String?
  public var giftBasket: String?
  public var longitude: Float?
  public var postalCode: String?
  public var instructions: String?
  public var city: String?
  public var delivery: String?
  public var street: String?
  public var caterer: String?
  public var florist: String?
  public var timeUpdated: String?
  public var label: String?
  public var defaultValue: Bool? = false
  public var editableFields: [String]?
  public var zipCode9: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    state = json[SerializationKeys.state].string
    numOfRests = json[SerializationKeys.numOfRests].int
    pickup = json[SerializationKeys.pickup].string
    timeMerchantChecked = json[SerializationKeys.timeMerchantChecked].string
    dateLastUsed = json[SerializationKeys.dateLastUsed].string
    bad = json[SerializationKeys.bad].int
    locationId = json[SerializationKeys.locationId].int
    latitude = json[SerializationKeys.latitude].float
    geoService = json[SerializationKeys.geoService].string
    phone = json[SerializationKeys.phone].string
    unitNumber = json[SerializationKeys.unitNumber].string
    zipCode = json[SerializationKeys.zipCode].string
    giftBasket = json[SerializationKeys.giftBasket].string
    longitude = json[SerializationKeys.longitude].float
    postalCode = json[SerializationKeys.postalCode].string
    instructions = json[SerializationKeys.instructions].string
    city = json[SerializationKeys.city].string
    delivery = json[SerializationKeys.delivery].string
    street = json[SerializationKeys.street].string
    caterer = json[SerializationKeys.caterer].string
    florist = json[SerializationKeys.florist].string
    timeUpdated = json[SerializationKeys.timeUpdated].string
    label = json[SerializationKeys.label].string
    defaultValue = json[SerializationKeys.defaultValue].boolValue
    if let items = json[SerializationKeys.editableFields].array { editableFields = items.map { $0.stringValue } }
    zipCode9 = json[SerializationKeys.zipCode9].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = numOfRests { dictionary[SerializationKeys.numOfRests] = value }
    if let value = pickup { dictionary[SerializationKeys.pickup] = value }
    if let value = timeMerchantChecked { dictionary[SerializationKeys.timeMerchantChecked] = value }
    if let value = dateLastUsed { dictionary[SerializationKeys.dateLastUsed] = value }
    if let value = bad { dictionary[SerializationKeys.bad] = value }
    if let value = locationId { dictionary[SerializationKeys.locationId] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = geoService { dictionary[SerializationKeys.geoService] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = unitNumber { dictionary[SerializationKeys.unitNumber] = value }
    if let value = zipCode { dictionary[SerializationKeys.zipCode] = value }
    if let value = giftBasket { dictionary[SerializationKeys.giftBasket] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = postalCode { dictionary[SerializationKeys.postalCode] = value }
    if let value = instructions { dictionary[SerializationKeys.instructions] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = delivery { dictionary[SerializationKeys.delivery] = value }
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = caterer { dictionary[SerializationKeys.caterer] = value }
    if let value = florist { dictionary[SerializationKeys.florist] = value }
    if let value = timeUpdated { dictionary[SerializationKeys.timeUpdated] = value }
    if let value = label { dictionary[SerializationKeys.label] = value }
    dictionary[SerializationKeys.defaultValue] = defaultValue
    if let value = editableFields { dictionary[SerializationKeys.editableFields] = value }
    if let value = zipCode9 { dictionary[SerializationKeys.zipCode9] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.numOfRests = aDecoder.decodeObject(forKey: SerializationKeys.numOfRests) as? Int
    self.pickup = aDecoder.decodeObject(forKey: SerializationKeys.pickup) as? String
    self.timeMerchantChecked = aDecoder.decodeObject(forKey: SerializationKeys.timeMerchantChecked) as? String
    self.dateLastUsed = aDecoder.decodeObject(forKey: SerializationKeys.dateLastUsed) as? String
    self.bad = aDecoder.decodeObject(forKey: SerializationKeys.bad) as? Int
    self.locationId = aDecoder.decodeObject(forKey: SerializationKeys.locationId) as? Int
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
    self.geoService = aDecoder.decodeObject(forKey: SerializationKeys.geoService) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.unitNumber = aDecoder.decodeObject(forKey: SerializationKeys.unitNumber) as? String
    self.zipCode = aDecoder.decodeObject(forKey: SerializationKeys.zipCode) as? String
    self.giftBasket = aDecoder.decodeObject(forKey: SerializationKeys.giftBasket) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
    self.postalCode = aDecoder.decodeObject(forKey: SerializationKeys.postalCode) as? String
    self.instructions = aDecoder.decodeObject(forKey: SerializationKeys.instructions) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.delivery = aDecoder.decodeObject(forKey: SerializationKeys.delivery) as? String
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.caterer = aDecoder.decodeObject(forKey: SerializationKeys.caterer) as? String
    self.florist = aDecoder.decodeObject(forKey: SerializationKeys.florist) as? String
    self.timeUpdated = aDecoder.decodeObject(forKey: SerializationKeys.timeUpdated) as? String
    self.label = aDecoder.decodeObject(forKey: SerializationKeys.label) as? String
    self.defaultValue = aDecoder.decodeBool(forKey: SerializationKeys.defaultValue)
    self.editableFields = aDecoder.decodeObject(forKey: SerializationKeys.editableFields) as? [String]
    self.zipCode9 = aDecoder.decodeObject(forKey: SerializationKeys.zipCode9) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(numOfRests, forKey: SerializationKeys.numOfRests)
    aCoder.encode(pickup, forKey: SerializationKeys.pickup)
    aCoder.encode(timeMerchantChecked, forKey: SerializationKeys.timeMerchantChecked)
    aCoder.encode(dateLastUsed, forKey: SerializationKeys.dateLastUsed)
    aCoder.encode(bad, forKey: SerializationKeys.bad)
    aCoder.encode(locationId, forKey: SerializationKeys.locationId)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(geoService, forKey: SerializationKeys.geoService)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(unitNumber, forKey: SerializationKeys.unitNumber)
    aCoder.encode(zipCode, forKey: SerializationKeys.zipCode)
    aCoder.encode(giftBasket, forKey: SerializationKeys.giftBasket)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(postalCode, forKey: SerializationKeys.postalCode)
    aCoder.encode(instructions, forKey: SerializationKeys.instructions)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(delivery, forKey: SerializationKeys.delivery)
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(caterer, forKey: SerializationKeys.caterer)
    aCoder.encode(florist, forKey: SerializationKeys.florist)
    aCoder.encode(timeUpdated, forKey: SerializationKeys.timeUpdated)
    aCoder.encode(label, forKey: SerializationKeys.label)
    aCoder.encode(defaultValue, forKey: SerializationKeys.defaultValue)
    aCoder.encode(editableFields, forKey: SerializationKeys.editableFields)
    aCoder.encode(zipCode9, forKey: SerializationKeys.zipCode9)
  }

}
