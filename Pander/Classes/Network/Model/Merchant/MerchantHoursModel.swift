//
//  MerchantHoursModel.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import ObjectMapper

class MerchantHoursModel: Mappable {
    var merchantId: String?
    var merchantName: String?
    var standardSchedule: ScheduleModel?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        merchantId       <- map["merchant_id"]
        merchantName     <- map["merchant_name"]
        standardSchedule <- map["standard_schedule"]
    }
}
