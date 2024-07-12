//
//  PNDeliveryAddress.swift
//
//  Created by Abdul Sami on 14/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNDeliveryAddress: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let active = "active"
    static let needId = "need_id"
    static let locationId = "location_id"
    static let addressType = "address_type"
    static let phone = "phone"
    static let unitType = "unit_type"
    static let unitNumber = "unit_number"
    static let zipCode = "zip_code"
    static let city = "city"
    static let confirmUnitChange = "confirm_unit_change"
    static let street = "street"
    static let addressStatus = "address_status"
    static let buildingId = "building_id"
    static let timeUpdated = "time_updated"
    static let thirdPartyAddress = "third_party_address"
    static let corporateId = "corporate_id"
    static let userId = "user_id"
  }

  // MARK: Properties
  public var state: String?
  public var active: String?
  public var needId: String?
  public var locationId: Int?
  public var addressType: String?
  public var phone: String?
  public var unitType: String?
  public var unitNumber: String?
  public var zipCode: String?
  public var city: String?
  public var confirmUnitChange: String?
  public var street: String?
  public var addressStatus: String?
  public var buildingId: Int?
  public var timeUpdated: String?
  public var thirdPartyAddress: String?
  public var corporateId: Int?
  public var userId: Int?

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
    active = json[SerializationKeys.active].string
    needId = json[SerializationKeys.needId].string
    locationId = json[SerializationKeys.locationId].int
    addressType = json[SerializationKeys.addressType].string
    phone = json[SerializationKeys.phone].string
    unitType = json[SerializationKeys.unitType].string
    unitNumber = json[SerializationKeys.unitNumber].string
    zipCode = json[SerializationKeys.zipCode].string
    city = json[SerializationKeys.city].string
    confirmUnitChange = json[SerializationKeys.confirmUnitChange].string
    street = json[SerializationKeys.street].string
    addressStatus = json[SerializationKeys.addressStatus].string
    buildingId = json[SerializationKeys.buildingId].int
    timeUpdated = json[SerializationKeys.timeUpdated].string
    thirdPartyAddress = json[SerializationKeys.thirdPartyAddress].string
    corporateId = json[SerializationKeys.corporateId].int
    userId = json[SerializationKeys.userId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = active { dictionary[SerializationKeys.active] = value }
    if let value = needId { dictionary[SerializationKeys.needId] = value }
    if let value = locationId { dictionary[SerializationKeys.locationId] = value }
    if let value = addressType { dictionary[SerializationKeys.addressType] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = unitType { dictionary[SerializationKeys.unitType] = value }
    if let value = unitNumber { dictionary[SerializationKeys.unitNumber] = value }
    if let value = zipCode { dictionary[SerializationKeys.zipCode] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = confirmUnitChange { dictionary[SerializationKeys.confirmUnitChange] = value }
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = addressStatus { dictionary[SerializationKeys.addressStatus] = value }
    if let value = buildingId { dictionary[SerializationKeys.buildingId] = value }
    if let value = timeUpdated { dictionary[SerializationKeys.timeUpdated] = value }
    if let value = thirdPartyAddress { dictionary[SerializationKeys.thirdPartyAddress] = value }
    if let value = corporateId { dictionary[SerializationKeys.corporateId] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.active = aDecoder.decodeObject(forKey: SerializationKeys.active) as? String
    self.needId = aDecoder.decodeObject(forKey: SerializationKeys.needId) as? String
    self.locationId = aDecoder.decodeObject(forKey: SerializationKeys.locationId) as? Int
    self.addressType = aDecoder.decodeObject(forKey: SerializationKeys.addressType) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.unitType = aDecoder.decodeObject(forKey: SerializationKeys.unitType) as? String
    self.unitNumber = aDecoder.decodeObject(forKey: SerializationKeys.unitNumber) as? String
    self.zipCode = aDecoder.decodeObject(forKey: SerializationKeys.zipCode) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.confirmUnitChange = aDecoder.decodeObject(forKey: SerializationKeys.confirmUnitChange) as? String
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.addressStatus = aDecoder.decodeObject(forKey: SerializationKeys.addressStatus) as? String
    self.buildingId = aDecoder.decodeObject(forKey: SerializationKeys.buildingId) as? Int
    self.timeUpdated = aDecoder.decodeObject(forKey: SerializationKeys.timeUpdated) as? String
    self.thirdPartyAddress = aDecoder.decodeObject(forKey: SerializationKeys.thirdPartyAddress) as? String
    self.corporateId = aDecoder.decodeObject(forKey: SerializationKeys.corporateId) as? Int
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(active, forKey: SerializationKeys.active)
    aCoder.encode(needId, forKey: SerializationKeys.needId)
    aCoder.encode(locationId, forKey: SerializationKeys.locationId)
    aCoder.encode(addressType, forKey: SerializationKeys.addressType)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(unitType, forKey: SerializationKeys.unitType)
    aCoder.encode(unitNumber, forKey: SerializationKeys.unitNumber)
    aCoder.encode(zipCode, forKey: SerializationKeys.zipCode)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(confirmUnitChange, forKey: SerializationKeys.confirmUnitChange)
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(addressStatus, forKey: SerializationKeys.addressStatus)
    aCoder.encode(buildingId, forKey: SerializationKeys.buildingId)
    aCoder.encode(timeUpdated, forKey: SerializationKeys.timeUpdated)
    aCoder.encode(thirdPartyAddress, forKey: SerializationKeys.thirdPartyAddress)
    aCoder.encode(corporateId, forKey: SerializationKeys.corporateId)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
  }

}
