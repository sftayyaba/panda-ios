//
//  PNMerchantManager.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import Alamofire
import PINCache
import SwiftyJSON

final class PNMerchantManager: PNBaseManager {

    //MARK: Shared Instance
    static let sharedInstance: PNMerchantManager = {
        let instance = PNMerchantManager()
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
