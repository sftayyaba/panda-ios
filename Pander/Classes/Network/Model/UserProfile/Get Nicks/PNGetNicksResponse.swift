//
//  PNGetNicksResponse.swift
//
//  Created by Abdul Sami on 10/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNGetNicksResponse: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cards = "cards"
    static let addresses = "addresses"
    static let code = "code"
  }

  // MARK: Properties
    public var cards: [String:String]!
  public var addresses: [String:String]!
  public var code: Int!

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
    
    cards = Dictionary( uniqueKeysWithValues: json[SerializationKeys.cards].map { (key,object) in (key,object.string!) } )
    addresses = Dictionary( uniqueKeysWithValues: json[SerializationKeys.addresses].map { (key,object) in (key,object.string!) } )

    code = json[SerializationKeys.code].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.)
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cards { dictionary[SerializationKeys.cards] = value }
    if let value = addresses { dictionary[SerializationKeys.addresses] = value }
    if let value = code { dictionary[SerializationKeys.code] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cards = aDecoder.decodeObject(forKey: SerializationKeys.cards) as! [String : String]
    self.addresses = aDecoder.decodeObject(forKey: SerializationKeys.addresses) as! [String : String]
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cards, forKey: SerializationKeys.cards)
    aCoder.encode(addresses, forKey: SerializationKeys.addresses)
    aCoder.encode(code, forKey: SerializationKeys.code)
  }

}
