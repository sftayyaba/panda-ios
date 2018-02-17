//
//  PNOrderDiscounts.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderDiscounts: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let type = "type"
    static let shortName = "short_name"
    static let name = "name"
  }

  // MARK: Properties
  public var type: String?
  public var shortName: String?
  public var name: String?

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
    type = json[SerializationKeys.type].string
    shortName = json[SerializationKeys.shortName].string
    name = json[SerializationKeys.name].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = shortName { dictionary[SerializationKeys.shortName] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.shortName = aDecoder.decodeObject(forKey: SerializationKeys.shortName) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(shortName, forKey: SerializationKeys.shortName)
    aCoder.encode(name, forKey: SerializationKeys.name)
  }

}
