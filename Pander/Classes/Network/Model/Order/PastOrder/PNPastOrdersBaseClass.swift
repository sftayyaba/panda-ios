//
//  PNBaseClass.swift
//
//  Created by Abdul Sami on 14/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNPastOrdersBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let code = "code"
    static let orders = "orders"
  }

  // MARK: Properties
  public var code: Int?
  public var orders: [PNOrders]?

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
    code = json[SerializationKeys.code].int
    if let items = json[SerializationKeys.orders].array { orders = items.map { PNOrders(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = code { dictionary[SerializationKeys.code] = value }
    if let value = orders { dictionary[SerializationKeys.orders] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
    self.orders = aDecoder.decodeObject(forKey: SerializationKeys.orders) as? [PNOrders]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(orders, forKey: SerializationKeys.orders)
  }

}
