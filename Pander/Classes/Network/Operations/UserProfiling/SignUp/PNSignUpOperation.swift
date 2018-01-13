//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNSignUpOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    var first_name: String
    var last_name: String
    var email: String
    var password: String
    
    
    init(FirstName first_name: String , LastName last_name: String, Email email:String, Password password: String ) {
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let json = JSON(response)
        
        
        if let code = json["code"].int{
            
            if code == PNApiResponseCodes.successResponse.rawValue{
                let codeResponseObject: PNUserCommonSuccessResponse = PNUserCommonSuccessResponse(json: JSON(response))
                
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
        
        let urlWithId:String = AppNetworkEndPoints.kUserSignUp
        
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
            "first_name":     self.first_name,
            "last_name":     self.last_name,
            "email": self.email,
            "password": self.password
        ]
    }
}



