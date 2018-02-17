//
//  PNLocationDDCResponseBaseClass.swift
//
//  Created by Abdul Sami on 08/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNDDCLocationResponseBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let location = "location"
    static let message = "message"
  }

  // MARK: Properties
  public var location: PNDDCLocation?
  public var message: [ErrorBaseClass]?

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
    location = PNDDCLocation(json: json[SerializationKeys.location])
    if let items = json[SerializationKeys.message].array {
        message = items.map { ErrorBaseClass(json: $0 as! JSON) }
    }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? PNDDCLocation
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? [ErrorBaseClass]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
