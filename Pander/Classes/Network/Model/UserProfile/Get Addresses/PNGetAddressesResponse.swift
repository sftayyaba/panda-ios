//
//  PNLocationResponse.swift
//
//  Created by Abdul Sami on 10/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNGetAddressesResponse: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let addresses = "addresses"
    static let code = "code"
  }

  // MARK: Properties
  public var addresses: [PNAddresses]?
  public var code: Int?

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
    if let items = json[SerializationKeys.addresses].array { addresses = items.map { PNAddresses(json: $0) } }
    code = json[SerializationKeys.code].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = addresses { dictionary[SerializationKeys.addresses] = value.map { $0.dictionaryRepresentation() } }
    if let value = code { dictionary[SerializationKeys.code] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.addresses = aDecoder.decodeObject(forKey: SerializationKeys.addresses) as? [PNAddresses]
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(addresses, forKey: SerializationKeys.addresses)
    aCoder.encode(code, forKey: SerializationKeys.code)
  }

}
