//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNForgotPasswordOperation: OnebyteNetworkOperationBase {
    
    //MARK: Instance Variables
    var email: String
    
    init(Email email: String ) {
        self.email = email
    }

    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startForgotPasswordOperation()
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
    private func startForgotPasswordOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kForgotPassword
            //+ "email=sheraz.ipa@gmail.com" + "/password=sheraz.ipa"
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
        return ["email":     self.email
        ]
    }
}
