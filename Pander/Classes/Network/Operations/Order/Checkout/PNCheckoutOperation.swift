//
//  PNCheckoutOperation.swift
//  Pander
//
//  Created by umaid naeem on 3/14/18.
//

import Foundation
import SwiftyJSON


class PNCheckoutOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    var resturantId : String
    var locationId : String
    var cardId : String
    var tip : Double
    var instructions : String
    
    init(
        ResturantId resturantId : String,
        LocationId locationId : String,
        CardId cardId : String,
        Tip tip : Double,
        Instructions instructions : String
        ) {
        self.resturantId = resturantId
        self.locationId = locationId
        self.cardId = cardId
        self.tip = tip
        self.instructions = instructions
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
                let codeResponseObject: PNOrderCheckout = PNOrderCheckout(json: JSON(response))
                
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
        
        let urlWithId:String = AppNetworkEndPoints.KOrderCartCheckOut + "\(self.resturantId)/"
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
        
        let body : [String : Any] = [ "location_id": self.locationId,
                                      "card_id":self.cardId,
                                      "tip":self.tip,
                                      "instructions":self.instructions]
        return body
    }
}
