//
//  PNFeeModel.swift
//  Pander
//
//  Created by Aamir Nazir on 23/03/2018.
//

import Foundation
import SwiftyJSON

public final class PNFeeModel: NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let value = "value"
    }

    // MARK: Properties
    public var value: Float?

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
        value = json[SerializationKeys.value].float
    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = value { dictionary[SerializationKeys.value] = value }
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? Float
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(value, forKey: SerializationKeys.value)
    }
}
