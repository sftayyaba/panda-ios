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

class PNBaseManager {
    
    static let baseSharedInstance: PNBaseManager = {
        let instance = PNBaseManager()
        return instance
    }()

    func notifyNetworkRequestStarted() {
        
    }
    
    func notifyNetworkRequestFinish() {
        
    }
}

