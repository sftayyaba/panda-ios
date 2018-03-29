//
//  PNOrderPaymentsUsed.swift
//  Pander
//
//  Created by Aamir Nazir on 29/03/2018.
//

import UIKit
import SwiftyJSON

public final class PNOrderPaymentsUsed: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let creditCard = "credit_card"
    }
    
    // MARK: Properties
    public var creditCard: [PNPaymentCreditCard]?
    
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
        if let items = json[SerializationKeys.creditCard].array { creditCard = items.map { PNPaymentCreditCard(json: $0) } }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = creditCard { dictionary[SerializationKeys.creditCard] = value }
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.creditCard = aDecoder.decodeObject(forKey: SerializationKeys.creditCard) as? [PNPaymentCreditCard]
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(creditCard, forKey: SerializationKeys.creditCard)
    }
}

