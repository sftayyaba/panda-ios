//
//  PNOrderRestaurantInfo.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderRestaurantInfo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let name = "name"
    static let id = "id"
    static let address = "address"
    static let phone = "phone"
    static let rating = "rating"
    static let longitude = "longitude"
    static let deliveryEstimate = "delivery_estimate"
    static let minOrder = "min_order"
  }

  // MARK: Properties
  public var latitude: Float?
  public var name: String?
  public var id: String?
  public var address: String?
  public var phone: String?
  public var rating: Float?
  public var longitude: Float?
  public var deliveryEstimate: Int?
  public var minOrder: Int?

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
    latitude = json[SerializationKeys.latitude].float
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].string
    address = json[SerializationKeys.address].string
    phone = json[SerializationKeys.phone].string
    rating = json[SerializationKeys.rating].float
    longitude = json[SerializationKeys.longitude].float
    deliveryEstimate = json[SerializationKeys.deliveryEstimate].int
    minOrder = json[SerializationKeys.minOrder].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = address { dictionary[SerializationKeys.address] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = deliveryEstimate { dictionary[SerializationKeys.deliveryEstimate] = value }
    if let value = minOrder { dictionary[SerializationKeys.minOrder] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
    self.deliveryEstimate = aDecoder.decodeObject(forKey: SerializationKeys.deliveryEstimate) as? Int
    self.minOrder = aDecoder.decodeObject(forKey: SerializationKeys.minOrder) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(address, forKey: SerializationKeys.address)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(deliveryEstimate, forKey: SerializationKeys.deliveryEstimate)
    aCoder.encode(minOrder, forKey: SerializationKeys.minOrder)
  }

}
