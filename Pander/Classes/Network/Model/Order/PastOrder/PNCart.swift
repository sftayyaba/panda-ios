//
//  PNCart.swift
//
//  Created by Abdul Sami on 14/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNCart: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let quantity = "quantity"
    static let itemKey = "item_key"
    static let id = "id"
    static let price = "price"
    static let type = "type"
  }

  // MARK: Properties
  public var isSelected: Bool = false
  public var name: String?
  public var quantity: Int?
  public var itemKey: Int?
  public var id: String?
  public var price: Float?
  public var type: String?

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
    name = json[SerializationKeys.name].string
    quantity = json[SerializationKeys.quantity].int
    itemKey = json[SerializationKeys.itemKey].int
    id = json[SerializationKeys.id].string
    price = json[SerializationKeys.price].float
    type = json[SerializationKeys.type].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = quantity { dictionary[SerializationKeys.quantity] = value }
    if let value = itemKey { dictionary[SerializationKeys.itemKey] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.quantity = aDecoder.decodeObject(forKey: SerializationKeys.quantity) as? Int
    self.itemKey = aDecoder.decodeObject(forKey: SerializationKeys.itemKey) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Float
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(quantity, forKey: SerializationKeys.quantity)
    aCoder.encode(itemKey, forKey: SerializationKeys.itemKey)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(type, forKey: SerializationKeys.type)
  }

}
