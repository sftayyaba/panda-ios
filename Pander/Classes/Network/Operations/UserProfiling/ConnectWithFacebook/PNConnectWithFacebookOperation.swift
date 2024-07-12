//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNConnectWithSocialOperation: OnebyteNetworkOperationBase {
    final let FB_TYPE = 0
    final let GMAIL_TYPE = 1
    
    
    //MARK: Instance Variables
    var fb_token: String
    var fb_user_id: String
    var email: String
    
    var type: Int
    
    var gmail_token: String
    
    init(FBToken fb_token: String , FBUserID fb_user_id: String , Email email: String ) {
        self.fb_token = fb_token
        self.fb_user_id = fb_user_id
        self.email = email
        
        self.type = FB_TYPE
        
        self.gmail_token = ""
    }
    
    init(GmailToken gmail_token: String) {
        self.fb_token = ""
        self.fb_user_id = ""
        self.email = ""
        
        self.type = GMAIL_TYPE
        
        self.gmail_token = gmail_token
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startLoginOperation()
    }
    
    
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let json = JSON(response)
        
        if let code = json["code"].int{
            
            if code >= PNApiResponseCodes.successResponse.rawValue{
                let loginBaseObject: PNUserCommonSuccessResponse = PNUserCommonSuccessResponse(json: JSON(response))

                self.safeCallDidFinishSuccessfullyCallback(responseObject: loginBaseObject)
                
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
    private func startLoginOperation() {
        
        let urlWithId:String = self.type == GMAIL_TYPE ? AppNetworkEndPoints.kSignUpWithGoogle : AppNetworkEndPoints.kSignUpWithFacebook
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
        if self.type == GMAIL_TYPE{
            return [
                "google_token":     self.gmail_token
            ]
        }
        
        return [
                "email":     self.email,
                "fb_token":     self.fb_token,
                "fb_user_id":     self.fb_user_id
        ]
    }
}

