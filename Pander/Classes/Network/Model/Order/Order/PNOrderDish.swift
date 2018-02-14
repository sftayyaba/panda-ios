//
//  PNOrderOrder.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderDish: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let minQty = "minQty"
    static let increment = "increment"
    static let unitPrice = "unit_price"
    static let descriptionValue = "description"
    static let approved = "approved"
    static let qty = "qty"
    static let maxQty = "maxQty"
    static let type = "type"
    static let submission = "submission"
    static let price = "price"
  }

  // MARK: Properties
    public var isSelected: Bool = false
  public var name: String?
  public var id: String?
  public var minQty: Int?
  public var increment: Int?
  public var unitPrice: Float?
  public var descriptionValue: String?
  public var approved: Bool? = false
  public var qty: Int?
  public var maxQty: Int?
  public var type: Int?
  public var submission: PNOrderSubmission?
  public var price: Float?

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
    id = json[SerializationKeys.id].string
    minQty = json[SerializationKeys.minQty].int
    increment = json[SerializationKeys.increment].int
    unitPrice = json[SerializationKeys.unitPrice].float
    descriptionValue = json[SerializationKeys.descriptionValue].string
    approved = json[SerializationKeys.approved].boolValue
    qty = json[SerializationKeys.qty].int
    maxQty = json[SerializationKeys.maxQty].int
    type = json[SerializationKeys.type].int
    submission = PNOrderSubmission(json: json[SerializationKeys.submission])
    price = json[SerializationKeys.price].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = minQty { dictionary[SerializationKeys.minQty] = value }
    if let value = increment { dictionary[SerializationKeys.increment] = value }
    if let value = unitPrice { dictionary[SerializationKeys.unitPrice] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    dictionary[SerializationKeys.approved] = approved
    if let value = qty { dictionary[SerializationKeys.qty] = value }
    if let value = maxQty { dictionary[SerializationKeys.maxQty] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = submission { dictionary[SerializationKeys.submission] = value.dictionaryRepresentation() }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.minQty = aDecoder.decodeObject(forKey: SerializationKeys.minQty) as? Int
    self.increment = aDecoder.decodeObject(forKey: SerializationKeys.increment) as? Int
    self.unitPrice = aDecoder.decodeObject(forKey: SerializationKeys.unitPrice) as? Float
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.approved = aDecoder.decodeBool(forKey: SerializationKeys.approved)
    self.qty = aDecoder.decodeObject(forKey: SerializationKeys.qty) as? Int
    self.maxQty = aDecoder.decodeObject(forKey: SerializationKeys.maxQty) as? Int
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? Int
    self.submission = aDecoder.decodeObject(forKey: SerializationKeys.submission) as? PNOrderSubmission
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(minQty, forKey: SerializationKeys.minQty)
    aCoder.encode(increment, forKey: SerializationKeys.increment)
    aCoder.encode(unitPrice, forKey: SerializationKeys.unitPrice)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(approved, forKey: SerializationKeys.approved)
    aCoder.encode(qty, forKey: SerializationKeys.qty)
    aCoder.encode(maxQty, forKey: SerializationKeys.maxQty)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(submission, forKey: SerializationKeys.submission)
    aCoder.encode(price, forKey: SerializationKeys.price)
  }

}
