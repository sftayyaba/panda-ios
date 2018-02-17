//
//  PNLocationDDCResponseLocation.swift
//
//  Created by Abdul Sami on 08/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNDDCLocation: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let city = "city"
    static let state = "state"
    static let phone = "phone"
    static let street = "street"
    static let zipCode = "zip_code"
    static let longitude = "longitude"
    static let crossStreets = "cross_streets"
    static let locationId = "location_id"
  }

  // MARK: Properties
  public var latitude: String?
  public var city: String?
  public var state: String?
  public var phone: String?
  public var street: String?
  public var zipCode: String?
  public var longitude: String?
  public var crossStreets: String?
  public var locationId: Int?

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
    latitude = json[SerializationKeys.latitude].string
    city = json[SerializationKeys.city].string
    state = json[SerializationKeys.state].string
    phone = json[SerializationKeys.phone].string
    street = json[SerializationKeys.street].string
    zipCode = json[SerializationKeys.zipCode].string
    longitude = json[SerializationKeys.longitude].string
    crossStreets = json[SerializationKeys.crossStreets].string
    locationId = json[SerializationKeys.locationId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = zipCode { dictionary[SerializationKeys.zipCode] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = crossStreets { dictionary[SerializationKeys.crossStreets] = value }
    if let value = locationId { dictionary[SerializationKeys.locationId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.zipCode = aDecoder.decodeObject(forKey: SerializationKeys.zipCode) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
    self.crossStreets = aDecoder.decodeObject(forKey: SerializationKeys.crossStreets) as? String
    self.locationId = aDecoder.decodeObject(forKey: SerializationKeys.locationId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(zipCode, forKey: SerializationKeys.zipCode)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(crossStreets, forKey: SerializationKeys.crossStreets)
    aCoder.encode(locationId, forKey: SerializationKeys.locationId)
  }

}
