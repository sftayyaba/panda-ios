//
//  PNPastOrderBaseClass.swift
//  Pander
//
//  Created by umaid naeem on 3/5/18.
//

import Foundation
import SwiftyJSON

public final class PNPastOrderBaseClass: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let code = "code"
        static let orders = "orders"
        static let internalStatus = "internal_status"
    }
    
    // MARK: Properties
    public var code: Int?
    public var orders: [PNOrderItems]?
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
        if let orderItems = json[SerializationKeys.orders].array { orders = orderItems.map { PNOrderItems(json: $0) } }
        internalStatus = json[SerializationKeys.internalStatus].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = code { dictionary[SerializationKeys.code] = value }
        if let value = orders { dictionary[SerializationKeys.orders] = value.map { $0.dictionaryRepresentation() } }
        if let value = internalStatus { dictionary[SerializationKeys.internalStatus] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
        self.orders = aDecoder.decodeObject(forKey: SerializationKeys.orders) as? [PNOrderItems]
        self.internalStatus = aDecoder.decodeObject(forKey: SerializationKeys.internalStatus) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: SerializationKeys.code)
        aCoder.encode(orders, forKey: SerializationKeys.orders)
        aCoder.encode(internalStatus, forKey: SerializationKeys.internalStatus)
    }
    
}
