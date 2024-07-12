//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNRemoveAddressOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    public var locationId: String
    
    init(
        LocationId locationId: String
        ) {
        self.locationId = locationId
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startLoginOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        
        let json = JSON(response)
        
        let codeResponseObject: PNDDCLocationResponseBaseClass = PNDDCLocationResponseBaseClass(json: json)
        
        if codeResponseObject.message?.count == 0{
            self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
        }else{
            self.safeCallDidFinishWithErrorCallback(error: codeResponseObject.message?.first)
            
        }
        //        self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
        
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startLoginOperation() {
        
        let urlWithId:String = AppNetworkEndPoints.kAddAddress+self.locationId
        
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkDDCRequest(methodType: .delete, path: urlWithId, parameters: nil)).responseJSON {response in
            
            if ((response.response?.statusCode) == 200){
                switch response.result {
                case .success(let data):
                    self.handleDidFinishedWithResponse(response: data as AnyObject!)
                    break
                case .failure(let error):
                    self.handleDidFinishedWithError(error: error)
                    break
                }
            }else{
                self.handleDidFinishedWithError(error: response.error)
            }
        }
    }
    
}

