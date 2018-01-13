////
////  PNCuisinesByZip.swift
////
////  Created by Shery on 12/01/2018
////  Copyright (c) $hery. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//public class PNCuisinesByZip: NSObject {
//
//    // MARK: Declaration for string constants to be used to decode and also serialize.
//    internal let kPNCuisinesByZip12345Key: String = "12345"
//
//
//    // MARK: Properties
//    public var a12345: [PNCuisine]?
//
//
//    // MARK: SwiftyJSON Initalizers
//    /**
//    Initates the class based on the object
//    - parameter object: The object of either Dictionary or Array kind that was passed.
//    - returns: An initalized instance of the class.
//    */
//    convenience public init(object: AnyObject) {
//        self.init(json: JSON(object))
//    }
//
//    /**
//    Initates the class based on the JSON that was passed.
//    - parameter json: JSON object from SwiftyJSON.
//    - returns: An initalized instance of the class.
//    */
//    public init(json: JSON) {
//        12345 = []
//        if let items = json[kPNCuisinesByZip12345Key].array {
//            for item in items {
//                12345?.append(PNCuisine(json: item))
//            }
//        } else {
//            12345 = nil
//        }
//
//    }
//
//
//    /**
//    Generates description of the object in the form of a NSDictionary.
//    - returns: A Key value pair containing all valid values in the object.
//    */
//    public func dictionaryRepresentation() -> [String : AnyObject ] {
//
//        var dictionary: [String : AnyObject ] = [ : ]
//        if 12345?.count > 0 {
//            var temp: [AnyObject] = []
//            for item in 12345! {
//                temp.append(item.dictionaryRepresentation())
//            }
//            dictionary.updateValue(temp, forKey: kPNCuisinesByZip12345Key)
//        }
//
//        return dictionary
//    }
//
//}

