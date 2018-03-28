//
//  DayScheduleModel.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import ObjectMapper

class DayScheduleModel: Mappable {

    var timesOpen: [OpenTimeModel]?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        timesOpen <- map["times_open"]
    }
}

