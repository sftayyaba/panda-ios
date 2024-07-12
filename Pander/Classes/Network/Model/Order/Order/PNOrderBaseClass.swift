//
//  PNOrderBaseClass.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let code = "code"
    static let recommendation = "recommendation"
    static let internalStatus = "internal_status"
  }

  // MARK: Properties
  public var code: Int?
  public var recommendation: PNOrderRecommendation?
  public var internalStatus: Int?

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
    recommendation = PNOrderRecommendation(json: json[SerializationKeys.recommendation])
    internalStatus = json[SerializationKeys.internalStatus].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = code { dictionary[SerializationKeys.code] = value }
    if let value = recommendation { dictionary[SerializationKeys.recommendation] = value.dictionaryRepresentation() }
    if let value = internalStatus { dictionary[SerializationKeys.internalStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
    self.recommendation = aDecoder.decodeObject(forKey: SerializationKeys.recommendation) as? PNOrderRecommendation
    self.internalStatus = aDecoder.decodeObject(forKey: SerializationKeys.internalStatus) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(recommendation, forKey: SerializationKeys.recommendation)
    aCoder.encode(internalStatus, forKey: SerializationKeys.internalStatus)
  }

}
