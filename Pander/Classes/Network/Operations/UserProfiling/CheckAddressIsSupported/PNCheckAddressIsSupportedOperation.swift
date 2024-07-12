//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNCheckAddressIsSupportedOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    var country_code: String
    var zip: String
    
    
    init(CountryCode country_code: String , Zip zip: String ) {
        self.country_code = country_code
        self.zip = zip
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let json = JSON(response)
        
        
        if let code = json["code"].int{
            
            if code >= PNApiResponseCodes.successResponse.rawValue{
                let codeResponseObject: PNCodeResponse = PNCodeResponse(json: JSON(response))
                
                self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
            }else if code <= PNApiResponseCodes.errorResponse.rawValue{
                let errorResponse: ErrorBaseClass = ErrorBaseClass(json: JSON(response))
                
                self.safeCallDidFinishSuccessfullyCallback(responseObject: errorResponse)
            }
        }
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startOperation() {
        
        let urlWithId:String = AppNetworkEndPoints.kAddressSupported
        OnebyteNetworkSessionManager.request(AppNetworkManager.openNetworkRequest(methodType: .post, path: urlWithId, parameters: self.createBody())).responseJSON {response in
            
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
    
    private func createBody() -> Dictionary<String, String>{
        return [
            "country_code":     self.country_code,
            "zip":     self.zip
        ]
    }
}


