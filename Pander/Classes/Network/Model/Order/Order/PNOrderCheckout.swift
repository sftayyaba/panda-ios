//
//  PNOrderCheckout.swift
//  Pander
//
//  Created by umaid naeem on 3/14/18.
//

import Foundation
import SwiftyJSON

public final class PNOrderCheckout: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let code = "code"
        static let orderId = "order_id"
        static let points = "delivery_points"
    }
    
    // MARK: Properties
    public var code: Int?
    public var orderId: Int?
    public var points: Int?
    
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
        orderId = json[SerializationKeys.orderId].int
        points = json[SerializationKeys.points].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = code { dictionary[SerializationKeys.code] = value }
        if let value = orderId { dictionary[SerializationKeys.orderId] = value }
        if let value = points { dictionary[SerializationKeys.points] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
        self.orderId = aDecoder.decodeObject(forKey: SerializationKeys.orderId) as? Int
        self.points = aDecoder.decodeObject(forKey: SerializationKeys.points) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: SerializationKeys.code)
        aCoder.encode(orderId, forKey: SerializationKeys.orderId)
        aCoder.encode(points, forKey: SerializationKeys.points)
    }
    
}

