//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNGetRecommendationsOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    var location: String
    var zip: String?
    
    
    init(Location location: String, Zip zip: String?) {
        self.location = location
        self.zip = zip
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
                let codeResponseObject: PNRecommendationsModel = PNRecommendationsModel(json: JSON(response))
                
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
    private func startLoginOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kGetRecommendations
        
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkRequest(methodType: .post, path: urlWithId, parameters: createBody())).responseJSON {response in
             
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
    
    private func createBody() -> Dictionary<String, Any>{
        if let zip = self.zip{
            return [ "locations" : "{\"US\": [{\"zip\":\"\(zip)\"}]}"
            ]
        }
        return [ "locations" : "{\"US\": \"\"}"
            ]
    }
}
