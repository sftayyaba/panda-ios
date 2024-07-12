//
//  PNOrderRawAll.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderRawAll: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let priceCompareItem = "price_compare_item"
    static let name = "name"
    static let maxPrice = "max_price"
    static let children = "children"
    static let popularFlag = "popular_flag"
    static let descriptionValue = "description"
    static let rating = "rating"
    static let type = "type"
    static let price = "price"
    static let maxQty = "max_qty"
    static let id = "id"
    static let increment = "increment"
    static let uniqueId = "unique_id"
    static let images = "images"
    static let minQty = "min_qty"
    static let popularRank = "popular_rank"
  }

  // MARK: Properties
  public var priceCompareItem: Bool? = false
  public var name: String?
  public var maxPrice: Int?
  public var children: [Any]?
  public var popularFlag: Bool? = false
  public var descriptionValue: String?
  public var rating: Float?
  public var type: String?
  public var price: Int?
  public var maxQty: Int?
  public var id: String?
  public var increment: Int?
  public var uniqueId: Int?
  public var images: [Any]?
  public var minQty: Int?
  public var popularRank: Bool? = false

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
    priceCompareItem = json[SerializationKeys.priceCompareItem].boolValue
    name = json[SerializationKeys.name].string
    maxPrice = json[SerializationKeys.maxPrice].int
    if let items = json[SerializationKeys.children].array { children = items.map { $0.object} }
    popularFlag = json[SerializationKeys.popularFlag].boolValue
    descriptionValue = json[SerializationKeys.descriptionValue].string
    rating = json[SerializationKeys.rating].float
    type = json[SerializationKeys.type].string
    price = json[SerializationKeys.price].int
    maxQty = json[SerializationKeys.maxQty].int
    id = json[SerializationKeys.id].string
    increment = json[SerializationKeys.increment].int
    uniqueId = json[SerializationKeys.uniqueId].int
    if let items = json[SerializationKeys.images].array { images = items.map { $0.object} }
    minQty = json[SerializationKeys.minQty].int
    popularRank = json[SerializationKeys.popularRank].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.priceCompareItem] = priceCompareItem
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = maxPrice { dictionary[SerializationKeys.maxPrice] = value }
    if let value = children { dictionary[SerializationKeys.children] = value }
    dictionary[SerializationKeys.popularFlag] = popularFlag
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = maxQty { dictionary[SerializationKeys.maxQty] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = increment { dictionary[SerializationKeys.increment] = value }
    if let value = uniqueId { dictionary[SerializationKeys.uniqueId] = value }
    if let value = images { dictionary[SerializationKeys.images] = value }
    if let value = minQty { dictionary[SerializationKeys.minQty] = value }
    dictionary[SerializationKeys.popularRank] = popularRank
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.priceCompareItem = aDecoder.decodeBool(forKey: SerializationKeys.priceCompareItem)
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.maxPrice = aDecoder.decodeObject(forKey: SerializationKeys.maxPrice) as? Int
    self.children = aDecoder.decodeObject(forKey: SerializationKeys.children) as? [Any]
    self.popularFlag = aDecoder.decodeBool(forKey: SerializationKeys.popularFlag)
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Int
    self.maxQty = aDecoder.decodeObject(forKey: SerializationKeys.maxQty) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.increment = aDecoder.decodeObject(forKey: SerializationKeys.increment) as? Int
    self.uniqueId = aDecoder.decodeObject(forKey: SerializationKeys.uniqueId) as? Int
    self.images = aDecoder.decodeObject(forKey: SerializationKeys.images) as? [Any]
    self.minQty = aDecoder.decodeObject(forKey: SerializationKeys.minQty) as? Int
    self.popularRank = aDecoder.decodeBool(forKey: SerializationKeys.popularRank)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(priceCompareItem, forKey: SerializationKeys.priceCompareItem)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(maxPrice, forKey: SerializationKeys.maxPrice)
    aCoder.encode(children, forKey: SerializationKeys.children)
    aCoder.encode(popularFlag, forKey: SerializationKeys.popularFlag)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(maxQty, forKey: SerializationKeys.maxQty)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(increment, forKey: SerializationKeys.increment)
    aCoder.encode(uniqueId, forKey: SerializationKeys.uniqueId)
    aCoder.encode(images, forKey: SerializationKeys.images)
    aCoder.encode(minQty, forKey: SerializationKeys.minQty)
    aCoder.encode(popularRank, forKey: SerializationKeys.popularRank)
  }

}
