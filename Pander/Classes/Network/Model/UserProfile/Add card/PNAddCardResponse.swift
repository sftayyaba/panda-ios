//
//  PNAddCardResponse.swift
//
//  Created by Abdul Sami on 10/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNAddCardResponse: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lastFour = "last_four"
    static let ccId = "cc_id"
    static let expYear = "exp_year"
    static let additionalData = "additional_data"
    static let expMonth = "exp_month"
    static let message = "message"
    static let ccType = "cc_type"
  }

  // MARK: Properties
  public var lastFour: String?
  public var ccId: String?
  public var expYear: String?
  public var additionalData: [Any]?
  public var expMonth: String?
  public var message: [ErrorBaseClass]?
  public var ccType: String?

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
    lastFour = json[SerializationKeys.lastFour].string
    ccId = json[SerializationKeys.ccId].string
    expYear = json[SerializationKeys.expYear].string
    if let items = json[SerializationKeys.additionalData].array { additionalData = items.map { $0.object} }
    expMonth = json[SerializationKeys.expMonth].string
    if let items = json[SerializationKeys.message].array {
        message = items.map { ErrorBaseClass(json: $0.object as! JSON) }
    }
    ccType = json[SerializationKeys.ccType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lastFour { dictionary[SerializationKeys.lastFour] = value }
    if let value = ccId { dictionary[SerializationKeys.ccId] = value }
    if let value = expYear { dictionary[SerializationKeys.expYear] = value }
    if let value = additionalData { dictionary[SerializationKeys.additionalData] = value }
    if let value = expMonth { dictionary[SerializationKeys.expMonth] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = ccType { dictionary[SerializationKeys.ccType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lastFour = aDecoder.decodeObject(forKey: SerializationKeys.lastFour) as? String
    self.ccId = aDecoder.decodeObject(forKey: SerializationKeys.ccId) as? String
    self.expYear = aDecoder.decodeObject(forKey: SerializationKeys.expYear) as? String
    self.additionalData = aDecoder.decodeObject(forKey: SerializationKeys.additionalData) as? [Any]
    self.expMonth = aDecoder.decodeObject(forKey: SerializationKeys.expMonth) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? [ErrorBaseClass]
    self.ccType = aDecoder.decodeObject(forKey: SerializationKeys.ccType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lastFour, forKey: SerializationKeys.lastFour)
    aCoder.encode(ccId, forKey: SerializationKeys.ccId)
    aCoder.encode(expYear, forKey: SerializationKeys.expYear)
    aCoder.encode(additionalData, forKey: SerializationKeys.additionalData)
    aCoder.encode(expMonth, forKey: SerializationKeys.expMonth)
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(ccType, forKey: SerializationKeys.ccType)
  }

}
