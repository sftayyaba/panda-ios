//
//  PNEdit&ReorderOperation.swift
//  Pander
//
//  Created by umaid naeem on 3/6/18.
//

import Foundation
import SwiftyJSON


class PNEditReorderOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    var ddc_token : String
    var searchAddress : String
    var addressCity : String
    var addressZip : String
    var addressId : String
    var reorderInfo : String
    
    init(
        DDCToken ddc_token : String,
        SearchAddress searchAddress : String,
        AddressCity addressCity : String,
        AddressZip addressZip : String,
        AddressId addressId : String,
        ReorderInfo reorderInfo : String
        ) {
        self.ddc_token = ddc_token
        self.searchAddress = searchAddress
        self.addressCity = addressCity
        self.addressZip = addressZip
        self.addressId = addressId
        self.reorderInfo = reorderInfo
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
                let codeResponseObject: PNGenerateOrder = PNGenerateOrder(json: JSON(response))
                
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
        
        let urlWithId:String = AppNetworkEndPoints.kEditAndReorder
        
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
        
        var body : [String : Any] = [ "ddc_token": self.ddc_token,
                                      "searchAddress": self.searchAddress,
                                      "addressCity": self.addressCity,
                                      "addressZip": self.addressZip,
                                      "addressId": self.addressId,
                                      "reorderInfo": self.reorderInfo
                                    ]
        
        return body
    }
}
