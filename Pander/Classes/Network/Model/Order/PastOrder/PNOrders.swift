//
//  PNOrders.swift
//
//  Created by Abdul Sami on 14/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PNOrders: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let confirmed = "confirmed"
    static let type = "type"
    static let fee = "fee"
    static let isStandardizedData = "is_standardized_data"
    static let locationId = "location_id"
    static let cart = "cart"
    static let isLaundryOrder = "is_laundry_order"
    static let cancelled = "cancelled"
    static let gift = "gift"
    static let total = "total"
    static let cuisine = "cuisine"
    static let dishSummary = "dish_summary"
    static let imageUrl = "image_url"
    static let favorite = "favorite"
    static let phone = "phone"
    static let name = "name"
    static let vertical = "vertical"
    static let merchantCategoryGroup = "merchant_category_group"
    static let orderId = "order_id"
    static let deliveryAddress = "delivery_address"
    static let merchantActive = "merchant_active"
    static let rating = "rating"
    static let orderDate = "order_date"
    static let merchantId = "merchant_id"
    static let logoUrl = "logo_url"
    static let deliveryDate = "delivery_date"
  }

  // MARK: Properties
  public var confirmed: Bool? = false
  public var type: String?
  public var fee: Int?
  public var isStandardizedData: Bool? = false
  public var locationId: String?
  public var cart: [PNCart]?
  public var isLaundryOrder: Bool? = false
  public var cancelled: Bool? = false
  public var gift: PNGift?
  public var total: Float?
  public var cuisine: String?
  public var dishSummary: String?
  public var imageUrl: String?
  public var favorite: Bool? = false
  public var phone: String?
  public var name: String?
  public var vertical: PNVertical?
  public var merchantCategoryGroup: [PNMerchantCategoryGroup]?
  public var orderId: String?
  public var deliveryAddress: PNDeliveryAddress?
  public var merchantActive: Bool? = false
  public var rating: Int?
  public var orderDate: String?
  public var merchantId: String?
  public var logoUrl: String?
  public var deliveryDate: String?

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
    confirmed = json[SerializationKeys.confirmed].boolValue
    type = json[SerializationKeys.type].string
    fee = json[SerializationKeys.fee].int
    isStandardizedData = json[SerializationKeys.isStandardizedData].boolValue
    locationId = json[SerializationKeys.locationId].string
    if let items = json[SerializationKeys.cart].array { cart = items.map { PNCart(json: $0) } }
    isLaundryOrder = json[SerializationKeys.isLaundryOrder].boolValue
    cancelled = json[SerializationKeys.cancelled].boolValue
    gift = PNGift(json: json[SerializationKeys.gift])
    total = json[SerializationKeys.total].float
    cuisine = json[SerializationKeys.cuisine].string
    dishSummary = json[SerializationKeys.dishSummary].string
    imageUrl = json[SerializationKeys.imageUrl].string
    favorite = json[SerializationKeys.favorite].boolValue
    phone = json[SerializationKeys.phone].string
    name = json[SerializationKeys.name].string
    vertical = PNVertical(json: json[SerializationKeys.vertical])
    if let items = json[SerializationKeys.merchantCategoryGroup].array { merchantCategoryGroup = items.map { PNMerchantCategoryGroup(json: $0) } }
    orderId = json[SerializationKeys.orderId].string
    deliveryAddress = PNDeliveryAddress(json: json[SerializationKeys.deliveryAddress])
    merchantActive = json[SerializationKeys.merchantActive].boolValue
    rating = json[SerializationKeys.rating].int
    orderDate = json[SerializationKeys.orderDate].string
    merchantId = json[SerializationKeys.merchantId].string
    logoUrl = json[SerializationKeys.logoUrl].string
    deliveryDate = json[SerializationKeys.deliveryDate].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.confirmed] = confirmed
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = fee { dictionary[SerializationKeys.fee] = value }
    dictionary[SerializationKeys.isStandardizedData] = isStandardizedData
    if let value = locationId { dictionary[SerializationKeys.locationId] = value }
    if let value = cart { dictionary[SerializationKeys.cart] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.isLaundryOrder] = isLaundryOrder
    dictionary[SerializationKeys.cancelled] = cancelled
    if let value = gift { dictionary[SerializationKeys.gift] = value.dictionaryRepresentation() }
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = cuisine { dictionary[SerializationKeys.cuisine] = value }
    if let value = dishSummary { dictionary[SerializationKeys.dishSummary] = value }
    if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
    dictionary[SerializationKeys.favorite] = favorite
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = vertical { dictionary[SerializationKeys.vertical] = value.dictionaryRepresentation() }
    if let value = merchantCategoryGroup { dictionary[SerializationKeys.merchantCategoryGroup] = value.map { $0.dictionaryRepresentation() } }
    if let value = orderId { dictionary[SerializationKeys.orderId] = value }
    if let value = deliveryAddress { dictionary[SerializationKeys.deliveryAddress] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.merchantActive] = merchantActive
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = orderDate { dictionary[SerializationKeys.orderDate] = value }
    if let value = merchantId { dictionary[SerializationKeys.merchantId] = value }
    if let value = logoUrl { dictionary[SerializationKeys.logoUrl] = value }
    if let value = deliveryDate { dictionary[SerializationKeys.deliveryDate] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.confirmed = aDecoder.decodeBool(forKey: SerializationKeys.confirmed)
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.fee = aDecoder.decodeObject(forKey: SerializationKeys.fee) as? Int
    self.isStandardizedData = aDecoder.decodeBool(forKey: SerializationKeys.isStandardizedData)
    self.locationId = aDecoder.decodeObject(forKey: SerializationKeys.locationId) as? String
    self.cart = aDecoder.decodeObject(forKey: SerializationKeys.cart) as? [PNCart]
    self.isLaundryOrder = aDecoder.decodeBool(forKey: SerializationKeys.isLaundryOrder)
    self.cancelled = aDecoder.decodeBool(forKey: SerializationKeys.cancelled)
    self.gift = aDecoder.decodeObject(forKey: SerializationKeys.gift) as? PNGift
    self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? Float
    self.cuisine = aDecoder.decodeObject(forKey: SerializationKeys.cuisine) as? String
    self.dishSummary = aDecoder.decodeObject(forKey: SerializationKeys.dishSummary) as? String
    self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    self.favorite = aDecoder.decodeBool(forKey: SerializationKeys.favorite)
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.vertical = aDecoder.decodeObject(forKey: SerializationKeys.vertical) as? PNVertical
    self.merchantCategoryGroup = aDecoder.decodeObject(forKey: SerializationKeys.merchantCategoryGroup) as? [PNMerchantCategoryGroup]
    self.orderId = aDecoder.decodeObject(forKey: SerializationKeys.orderId) as? String
    self.deliveryAddress = aDecoder.decodeObject(forKey: SerializationKeys.deliveryAddress) as? PNDeliveryAddress
    self.merchantActive = aDecoder.decodeBool(forKey: SerializationKeys.merchantActive)
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Int
    self.orderDate = aDecoder.decodeObject(forKey: SerializationKeys.orderDate) as? String
    self.merchantId = aDecoder.decodeObject(forKey: SerializationKeys.merchantId) as? String
    self.logoUrl = aDecoder.decodeObject(forKey: SerializationKeys.logoUrl) as? String
    self.deliveryDate = aDecoder.decodeObject(forKey: SerializationKeys.deliveryDate) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(confirmed, forKey: SerializationKeys.confirmed)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(fee, forKey: SerializationKeys.fee)
    aCoder.encode(isStandardizedData, forKey: SerializationKeys.isStandardizedData)
    aCoder.encode(locationId, forKey: SerializationKeys.locationId)
    aCoder.encode(cart, forKey: SerializationKeys.cart)
    aCoder.encode(isLaundryOrder, forKey: SerializationKeys.isLaundryOrder)
    aCoder.encode(cancelled, forKey: SerializationKeys.cancelled)
    aCoder.encode(gift, forKey: SerializationKeys.gift)
    aCoder.encode(total, forKey: SerializationKeys.total)
    aCoder.encode(cuisine, forKey: SerializationKeys.cuisine)
    aCoder.encode(dishSummary, forKey: SerializationKeys.dishSummary)
    aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    aCoder.encode(favorite, forKey: SerializationKeys.favorite)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(vertical, forKey: SerializationKeys.vertical)
    aCoder.encode(merchantCategoryGroup, forKey: SerializationKeys.merchantCategoryGroup)
    aCoder.encode(orderId, forKey: SerializationKeys.orderId)
    aCoder.encode(deliveryAddress, forKey: SerializationKeys.deliveryAddress)
    aCoder.encode(merchantActive, forKey: SerializationKeys.merchantActive)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(orderDate, forKey: SerializationKeys.orderDate)
    aCoder.encode(merchantId, forKey: SerializationKeys.merchantId)
    aCoder.encode(logoUrl, forKey: SerializationKeys.logoUrl)
    aCoder.encode(deliveryDate, forKey: SerializationKeys.deliveryDate)
  }

}
