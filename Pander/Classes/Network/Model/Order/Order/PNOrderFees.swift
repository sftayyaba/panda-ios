//
//  PNOrderFees.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderFees: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let untaxedPctFees = "untaxedPctFees"
    static let untaxedFlatFees = "untaxedFlatFees"
    static let salesTax = "salesTax"
    static let taxedFlatFees = "taxedFlatFees"
    static let taxedPctFees = "taxedPctFees"
  }

  // MARK: Properties
  public var untaxedPctFees: [Any]?
  public var untaxedFlatFees: [Any]?
  public var salesTax: Float?
  public var taxedFlatFees: [Any]?
  public var taxedPctFees: [Any]?

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
    if let items = json[SerializationKeys.untaxedPctFees].array { untaxedPctFees = items.map { $0.object} }
    if let items = json[SerializationKeys.untaxedFlatFees].array { untaxedFlatFees = items.map { $0.object} }
    salesTax = json[SerializationKeys.salesTax].float
    if let items = json[SerializationKeys.taxedFlatFees].array { taxedFlatFees = items.map { $0.object} }
    if let items = json[SerializationKeys.taxedPctFees].array { taxedPctFees = items.map { $0.object} }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = untaxedPctFees { dictionary[SerializationKeys.untaxedPctFees] = value }
    if let value = untaxedFlatFees { dictionary[SerializationKeys.untaxedFlatFees] = value }
    if let value = salesTax { dictionary[SerializationKeys.salesTax] = value }
    if let value = taxedFlatFees { dictionary[SerializationKeys.taxedFlatFees] = value }
    if let value = taxedPctFees { dictionary[SerializationKeys.taxedPctFees] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.untaxedPctFees = aDecoder.decodeObject(forKey: SerializationKeys.untaxedPctFees) as? [Any]
    self.untaxedFlatFees = aDecoder.decodeObject(forKey: SerializationKeys.untaxedFlatFees) as? [Any]
    self.salesTax = aDecoder.decodeObject(forKey: SerializationKeys.salesTax) as? Float
    self.taxedFlatFees = aDecoder.decodeObject(forKey: SerializationKeys.taxedFlatFees) as? [Any]
    self.taxedPctFees = aDecoder.decodeObject(forKey: SerializationKeys.taxedPctFees) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(untaxedPctFees, forKey: SerializationKeys.untaxedPctFees)
    aCoder.encode(untaxedFlatFees, forKey: SerializationKeys.untaxedFlatFees)
    aCoder.encode(salesTax, forKey: SerializationKeys.salesTax)
    aCoder.encode(taxedFlatFees, forKey: SerializationKeys.taxedFlatFees)
    aCoder.encode(taxedPctFees, forKey: SerializationKeys.taxedPctFees)
  }

}
