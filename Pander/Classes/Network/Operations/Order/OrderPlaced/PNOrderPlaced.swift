//
//  PNOrderPlaced.swift
//  Pander
//
//  Created by Zeeshan on 04/03/2018.
//

import Foundation
import SwiftyJSON


class PNOrderOrderCartClear: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    var resturantId : String
    
    
    init(
        ResturantId resturantId : String
        ) {
        self.resturantId = resturantId
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
        
        let urlWithId:String = AppNetworkEndPoints.KOrderCartClear + "\(self.resturantId)/"
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
        
        let body : [String : Any] = [ "resturantId": self.resturantId ]
        return body
    }
}


