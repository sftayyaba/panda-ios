//
//  PNPaymentCreditCard.swift
//  Pander
//
//  Created by Aamir Nazir on 29/03/2018.
//

import UIKit
import SwiftyJSON

public final class PNPaymentCreditCard: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let amount = "amount"
        static let lastFourDigits = "last_four"
    }

    // MARK: Properties
    public var id: Int?
    public var amount: Double?
    public var lastFourDigits: String?

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
        id = json[SerializationKeys.id].int
        amount = json[SerializationKeys.amount].double
        lastFourDigits = json[SerializationKeys.lastFourDigits].string
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = amount { dictionary[SerializationKeys.amount] = value }
        if let value = lastFourDigits { dictionary[SerializationKeys.lastFourDigits] = value }
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.amount = aDecoder.decodeObject(forKey: SerializationKeys.amount) as? Double
        self.lastFourDigits = aDecoder.decodeObject(forKey: SerializationKeys.lastFourDigits) as? String
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(amount, forKey: SerializationKeys.amount)
        aCoder.encode(lastFourDigits, forKey: SerializationKeys.lastFourDigits)
    }
}
