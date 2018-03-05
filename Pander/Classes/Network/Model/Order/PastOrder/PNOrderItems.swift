//
//  PNOrderItems.swift
//  Pander
//
//  Created by umaid naeem on 3/5/18.
//

import Foundation
import Foundation
import SwiftyJSON

public final class PNOrderItems: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let cuisine = "cuisine"
        static let image_url = "image_url"
        static let dish_summary = "dish_summary"
        static let panderType = "panderType"
        static let panderRating = "panderRating"
        
    }
    
    // MARK: Properties
    public var cuisine: String?
    public var image_url: String?
    public var dish_summary: String?
    public var panderType: String?
    public var panderRating: Float?
    
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
        cuisine = json[SerializationKeys.cuisine].string
        image_url = json[SerializationKeys.image_url].string
        dish_summary = json[SerializationKeys.dish_summary].string
        panderType = json[SerializationKeys.panderType].string
        panderRating = json[SerializationKeys.panderRating].float
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = cuisine { dictionary[SerializationKeys.cuisine] = value }
        if let value = image_url { dictionary[SerializationKeys.image_url] = value }
        if let value = dish_summary { dictionary[SerializationKeys.dish_summary] = value }
        if let value = panderType { dictionary[SerializationKeys.panderType] = value }
        if let value = panderRating { dictionary[SerializationKeys.panderRating] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.cuisine = aDecoder.decodeObject(forKey: SerializationKeys.cuisine) as? String
        self.image_url = aDecoder.decodeObject(forKey: SerializationKeys.image_url) as? String
        self.dish_summary = aDecoder.decodeObject(forKey: SerializationKeys.dish_summary) as? String
        self.panderType = aDecoder.decodeObject(forKey: SerializationKeys.panderType) as? String
        self.panderRating = aDecoder.decodeObject(forKey: SerializationKeys.panderRating) as? Float
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(cuisine, forKey: SerializationKeys.cuisine)
        aCoder.encode(image_url, forKey: SerializationKeys.image_url)
        aCoder.encode(dish_summary, forKey: SerializationKeys.dish_summary)
        aCoder.encode(panderType, forKey: SerializationKeys.panderType)
        aCoder.encode(panderRating, forKey: SerializationKeys.panderRating)
    }
    
}
