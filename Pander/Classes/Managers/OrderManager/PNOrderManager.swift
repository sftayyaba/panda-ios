//
//  JNUserManager.swift
//  JobsNow
//
//  Created by Shery on 15/11/2017.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import Alamofire
import PINCache
import SwiftyJSON

final class PNOrderManager: PNBaseManager {

    //MARK: Instance Variables
    var generatedOrderId: String?
    
    var generatedOrder: PNOrderBaseClass?
    var placedOrderclear: PNOrderBaseClass?
    var prevRestaurentIds: [String] = [String]()
    //MARK: Shared Instance
    static let sharedInstance: PNOrderManager = {
        let instance = PNOrderManager()
        return instance
    }()
    
    
    //MARK: CallBacks
    override func notifyNetworkRequestStarted() {
        super.notifyNetworkRequestStarted()
    }
    
    override func notifyNetworkRequestFinish() {
        super.notifyNetworkRequestFinish()
    }
    
    
}
