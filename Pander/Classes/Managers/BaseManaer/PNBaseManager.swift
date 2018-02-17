//
//  BaseManager.swift
//  JobsNow
//
//  Created by Shery on 15/11/2017.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation

typealias PNSuccessBlock = (AnyObject?) -> Void
typealias PNSuccessBlockWithCount = (Int) -> Void

typealias PNFailureBlock = (Error? ) -> Void

enum PNNotificationTypes: String{
    case networkRequestStarted = "network_request_started"
    case networkRequestStopped = "network_request_stopped"
}

class PNBaseManager {
    
    static let baseSharedInstance: PNBaseManager = {
        let instance = PNBaseManager()
        return instance
    }()

    func notifyNetworkRequestStarted() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(PNNotificationTypes.networkRequestStarted.rawValue), object: nil)
        }
    }
    
    func notifyNetworkRequestFinish() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(PNNotificationTypes.networkRequestStopped.rawValue), object: nil)
        }
    }
}

