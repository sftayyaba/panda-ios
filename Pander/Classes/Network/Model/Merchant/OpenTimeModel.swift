//
//  OpenTimeModel.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import ObjectMapper

class OpenTimeModel: Mappable {

    var start: String?
    var end: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        start <- map["start"]
        end   <- map["end"]
    }
}
