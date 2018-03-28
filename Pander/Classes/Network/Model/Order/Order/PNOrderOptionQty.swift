//
//  PNOrderOptionQty.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderOptionQty: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "option_qty"
    static let pE2705200231232233 = "PE-2705-200-231-232-233"
  }

  // MARK: Properties
  public var pE2705200231232233: Int?
    public var name:String?
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
    pE2705200231232233 = json[SerializationKeys.pE2705200231232233].int
    name = json[SerializationKeys.name].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pE2705200231232233 { dictionary[SerializationKeys.pE2705200231232233] = value }
    if let value = name {dictionary[SerializationKeys.name] = value}
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pE2705200231232233 = aDecoder.decodeObject(forKey: SerializationKeys.pE2705200231232233) as? Int
    self.name = aDecoder.decodeObject(forKey:SerializationKeys.name) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pE2705200231232233, forKey: SerializationKeys.pE2705200231232233)
    aCoder.encode(name, forKey:SerializationKeys.name)
  }

}
