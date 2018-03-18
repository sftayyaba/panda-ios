//
//  PNReorderOperation.swift
//  Pander
//
//  Created by umaid naeem on 16/03/2018.
//

import Foundation
import SwiftyJSON


class PNReorderOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    var reorderId : String
    
    init(
        ReorderId reorderId : String
        ) {
        self.reorderId = reorderId
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
                let codeResponseObject: PNOrderBaseClass = PNOrderBaseClass(json: JSON(response))
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
        
        let urlWithId:String = AppNetworkEndPoints.kOrderReOrder + "\(self.reorderId)/"
        
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkRequest(methodType: .post, path: urlWithId, parameters: nil)).responseJSON {response in
            
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
