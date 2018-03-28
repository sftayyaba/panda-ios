//
//  ScheduleModel.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import ObjectMapper

class ScheduleModel: Mappable {

    var business: [String : DayScheduleModel]?
    var delivery: [String : DayScheduleModel]?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        business <- map["business"]
        delivery <- map["delivery"]
    }
}
