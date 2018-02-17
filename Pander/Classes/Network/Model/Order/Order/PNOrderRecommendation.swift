//
//  PNOrderRecommendation.swift
//
//  Created by Abdul Sami on 09/02/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrderRecommendation: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let alcoholIds = "alcoholIds"
    static let rawDesserts = "rawDesserts"
    static let totalPrice = "totalPrice"
    static let rawDrinks = "rawDrinks"
    static let rawCoffees = "rawCoffees"
    static let fees = "fees"
    static let rawEntrees = "rawEntrees"
    static let orderConcernMessage = "orderConcernMessage"
    static let rawAppetizers = "rawAppetizers"
    static let status = "status"
    static let orderConcern = "orderConcern"
    static let rawAll = "rawAll"
    static let discounts = "discounts"
    static let restTriedIds = "restTriedIds"
    static let imageUrl = "image_url"
    static let restaurantInfo = "restaurant_info"
    static let firstOrder = "firstOrder"
    static let order = "order"
    static let submission = "submission"
  }

  // MARK: Properties
  public var alcoholIds: String?
  public var rawDesserts: [PNOrderDish]?
  public var totalPrice: Int?
  public var rawDrinks: [PNOrderDish]?
  public var rawCoffees: [PNOrderDish]?
  public var fees: PNOrderFees?
  public var rawEntrees: [PNOrderDish]?
  public var orderConcernMessage: String?
  public var rawAppetizers: [PNOrderDish]?
  public var status: Int?
  public var orderConcern: Bool? = false
  public var rawAll: [PNOrderDish]?
  public var discounts: [PNOrderDiscounts]?
  public var restTriedIds: [String]?
  public var imageUrl: String?
  public var restaurantInfo: PNOrderRestaurantInfo?
  public var firstOrder: Bool? = false
  public var order: [PNOrderDish]?
  public var submission: [PNOrderSubmission]?

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
    alcoholIds = json[SerializationKeys.alcoholIds].string
    if let items = json[SerializationKeys.rawDesserts].array { rawDesserts = items.map { PNOrderDish(json: $0) } }
    totalPrice = json[SerializationKeys.totalPrice].int
    if let items = json[SerializationKeys.rawDrinks].array { rawDrinks = items.map { PNOrderDish(json: $0) } }
    if let items = json[SerializationKeys.rawCoffees].array { rawCoffees = items.map { PNOrderDish(json: $0) } }
    fees = PNOrderFees(json: json[SerializationKeys.fees])
    if let items = json[SerializationKeys.rawEntrees].array { rawEntrees = items.map { PNOrderDish(json: $0) } }
    orderConcernMessage = json[SerializationKeys.orderConcernMessage].string
    if let items = json[SerializationKeys.rawAppetizers].array { rawAppetizers = items.map { PNOrderDish(json: $0) } }
    status = json[SerializationKeys.status].int
    orderConcern = json[SerializationKeys.orderConcern].boolValue
    if let items = json[SerializationKeys.rawAll].array { rawAll = items.map { PNOrderDish(json: $0) } }
    if let items = json[SerializationKeys.discounts].array { discounts = items.map { PNOrderDiscounts(json: $0) } }
    if let items = json[SerializationKeys.restTriedIds].array { restTriedIds = items.map { $0.stringValue } }
    imageUrl = json[SerializationKeys.imageUrl].string
    restaurantInfo = PNOrderRestaurantInfo(json: json[SerializationKeys.restaurantInfo])
    firstOrder = json[SerializationKeys.firstOrder].boolValue
    if let items = json[SerializationKeys.order].array { order = items.map { PNOrderDish(json: $0) } }
    if let items = json[SerializationKeys.submission].array { submission = items.map { PNOrderSubmission(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = alcoholIds { dictionary[SerializationKeys.alcoholIds] = value }
    if let value = rawDesserts { dictionary[SerializationKeys.rawDesserts] = value.map { $0.dictionaryRepresentation() } }
    if let value = totalPrice { dictionary[SerializationKeys.totalPrice] = value }
    if let value = rawDrinks { dictionary[SerializationKeys.rawDrinks] = value.map { $0.dictionaryRepresentation() } }
    if let value = rawCoffees { dictionary[SerializationKeys.rawCoffees] = value }
    if let value = fees { dictionary[SerializationKeys.fees] = value.dictionaryRepresentation() }
    if let value = rawEntrees { dictionary[SerializationKeys.rawEntrees] = value }
    if let value = orderConcernMessage { dictionary[SerializationKeys.orderConcernMessage] = value }
    if let value = rawAppetizers { dictionary[SerializationKeys.rawAppetizers] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[SerializationKeys.status] = value }
    dictionary[SerializationKeys.orderConcern] = orderConcern
    if let value = rawAll { dictionary[SerializationKeys.rawAll] = value.map { $0.dictionaryRepresentation() } }
    if let value = discounts { dictionary[SerializationKeys.discounts] = value.map { $0.dictionaryRepresentation() } }
    if let value = restTriedIds { dictionary[SerializationKeys.restTriedIds] = value }
    if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
    if let value = restaurantInfo { dictionary[SerializationKeys.restaurantInfo] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.firstOrder] = firstOrder
    if let value = order { dictionary[SerializationKeys.order] = value.map { $0.dictionaryRepresentation() } }
    if let value = submission { dictionary[SerializationKeys.submission] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.alcoholIds = aDecoder.decodeObject(forKey: SerializationKeys.alcoholIds) as? String
    self.rawDesserts = aDecoder.decodeObject(forKey: SerializationKeys.rawDesserts) as? [PNOrderDish]
    self.totalPrice = aDecoder.decodeObject(forKey: SerializationKeys.totalPrice) as? Int
    self.rawDrinks = aDecoder.decodeObject(forKey: SerializationKeys.rawDrinks) as? [PNOrderDish]
    self.rawCoffees = aDecoder.decodeObject(forKey: SerializationKeys.rawCoffees) as? [PNOrderDish]
    self.fees = aDecoder.decodeObject(forKey: SerializationKeys.fees) as? PNOrderFees
    self.rawEntrees = aDecoder.decodeObject(forKey: SerializationKeys.rawEntrees) as? [PNOrderDish]
    self.orderConcernMessage = aDecoder.decodeObject(forKey: SerializationKeys.orderConcernMessage) as? String
    self.rawAppetizers = aDecoder.decodeObject(forKey: SerializationKeys.rawAppetizers) as? [PNOrderDish]
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.orderConcern = aDecoder.decodeBool(forKey: SerializationKeys.orderConcern)
    self.rawAll = aDecoder.decodeObject(forKey: SerializationKeys.rawAll) as? [PNOrderDish]
    self.discounts = aDecoder.decodeObject(forKey: SerializationKeys.discounts) as? [PNOrderDiscounts]
    self.restTriedIds = aDecoder.decodeObject(forKey: SerializationKeys.restTriedIds) as? [String]
    self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    self.restaurantInfo = aDecoder.decodeObject(forKey: SerializationKeys.restaurantInfo) as? PNOrderRestaurantInfo
    self.firstOrder = aDecoder.decodeBool(forKey: SerializationKeys.firstOrder)
    self.order = aDecoder.decodeObject(forKey: SerializationKeys.order) as? [PNOrderDish]
    self.submission = aDecoder.decodeObject(forKey: SerializationKeys.submission) as? [PNOrderSubmission]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(alcoholIds, forKey: SerializationKeys.alcoholIds)
    aCoder.encode(rawDesserts, forKey: SerializationKeys.rawDesserts)
    aCoder.encode(totalPrice, forKey: SerializationKeys.totalPrice)
    aCoder.encode(rawDrinks, forKey: SerializationKeys.rawDrinks)
    aCoder.encode(rawCoffees, forKey: SerializationKeys.rawCoffees)
    aCoder.encode(fees, forKey: SerializationKeys.fees)
    aCoder.encode(rawEntrees, forKey: SerializationKeys.rawEntrees)
    aCoder.encode(orderConcernMessage, forKey: SerializationKeys.orderConcernMessage)
    aCoder.encode(rawAppetizers, forKey: SerializationKeys.rawAppetizers)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(orderConcern, forKey: SerializationKeys.orderConcern)
    aCoder.encode(rawAll, forKey: SerializationKeys.rawAll)
    aCoder.encode(discounts, forKey: SerializationKeys.discounts)
    aCoder.encode(restTriedIds, forKey: SerializationKeys.restTriedIds)
    aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    aCoder.encode(restaurantInfo, forKey: SerializationKeys.restaurantInfo)
    aCoder.encode(firstOrder, forKey: SerializationKeys.firstOrder)
    aCoder.encode(order, forKey: SerializationKeys.order)
    aCoder.encode(submission, forKey: SerializationKeys.submission)
  }

}
