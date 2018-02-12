//
//  PNOrderSubmission.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderSubmission: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let itemId = "item_id"
    static let optionQty = "option_qty"
    static let itemQty = "item_qty"
  }

  // MARK: Properties
  public var itemId: String?
  public var optionQty: PNOrderOptionQty?
  public var itemQty: Int?

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
    itemId = json[SerializationKeys.itemId].string
    optionQty = PNOrderOptionQty(json: json[SerializationKeys.optionQty])
    itemQty = json[SerializationKeys.itemQty].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = itemId { dictionary[SerializationKeys.itemId] = value }
    if let value = optionQty { dictionary[SerializationKeys.optionQty] = value.dictionaryRepresentation() }
    if let value = itemQty { dictionary[SerializationKeys.itemQty] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.itemId = aDecoder.decodeObject(forKey: SerializationKeys.itemId) as? String
    self.optionQty = aDecoder.decodeObject(forKey: SerializationKeys.optionQty) as? PNOrderOptionQty
    self.itemQty = aDecoder.decodeObject(forKey: SerializationKeys.itemQty) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(itemId, forKey: SerializationKeys.itemId)
    aCoder.encode(optionQty, forKey: SerializationKeys.optionQty)
    aCoder.encode(itemQty, forKey: SerializationKeys.itemQty)
  }

}
