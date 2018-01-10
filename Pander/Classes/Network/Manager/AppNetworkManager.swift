//
//  File.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import Alamofire
import OnebyteSwiftNetworkCycle

class AppNetworkManager {
    // MARK: Class Variables
    static let sharedInstance = AppNetworkManager()
    
    static func openNetworkRequest (methodType: Alamofire.HTTPMethod!, path: String?, parameters: [String : String]?) -> OnebyteNetworkRequest {
        OnebyteNetworkRequest.baseURLString = AppNetworkConstants.kBaseURLTestingString
        OnebyteNetworkRequest.path = path
        OnebyteNetworkRequest.method = methodType
        OnebyteNetworkRequest.parameters = parameters
        OnebyteNetworkRequest.headers = nil
        
        return OnebyteNetworkRequest.InitiateRequest()
    }
    
    static func openNetworkRequestWithNonStringLeaves (methodType: Alamofire.HTTPMethod!, path: String?, parameters: [String : Any]?) -> OnebyteNetworkRequest {
        OnebyteNetworkRequest.baseURLString = AppNetworkConstants.kBaseURLTestingString
        OnebyteNetworkRequest.path = path
        OnebyteNetworkRequest.method = methodType
        OnebyteNetworkRequest.parameters = parameters as? [String : String]
        OnebyteNetworkRequest.headers = nil
        
        return OnebyteNetworkRequest.InitiateRequest()
    }
    

    static func closeNetworkRequest (methodType: Alamofire.HTTPMethod!, path: String?, parameters: [String : String]?) -> OnebyteNetworkRequest {
        OnebyteNetworkRequest.baseURLString = AppNetworkConstants.kBaseURLTestingString
        OnebyteNetworkRequest.path = path
        OnebyteNetworkRequest.method = methodType
        OnebyteNetworkRequest.parameters = parameters
        
        //Add header dictionary e.g
//        if let token = JNUserManager.sharedInstance.token{
//            OnebyteNetworkRequest.headers = ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
//        }
        return OnebyteNetworkRequest.InitiateRequest()
    }
}
