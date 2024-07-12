//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import OnebyteSwiftNetworkCycle
import SwiftyJSON

class PNForgotPasswordOperation: OnebyteNetworkOperationBase {
    
    //MARK: Instance Variables
    var email: String?
    var password: String?
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startLoginOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let loginBaseObject: PNUserCommonSuccessResponse = PNUserCommonSuccessResponse(json: JSON(response))
        
        self.safeCallDidFinishSuccessfullyCallback(responseObject: loginBaseObject)
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startLoginOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kUserLogin
            //+ "email=sheraz.ipa@gmail.com" + "/password=sheraz.ipa"
        OnebyteNetworkSessionManager.sharedInstance.request(AppNetworkManager.openNetworkRequest(methodType: .post, path: urlWithId, parameters: createBody())).responseJSON {response in
            
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
        return ["email":     self.email!,
                "password":     self.password!
        ]
    }
}
