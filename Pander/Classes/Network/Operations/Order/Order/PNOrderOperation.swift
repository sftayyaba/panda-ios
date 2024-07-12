//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON


class PNOrderOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables

    var ddc_token : String
    var searchAddress : String
    var addressCity : String
    var addressZip : String
    var addressId : String
    var category : Int
    var cuisine : String
    var groupSize : Int
    var budget : Int
    var orderMode :Int
    var restsTried : String?
    
    init(
            DDCToken ddc_token : String,
            SearchAddress searchAddress : String,
            AddressCity addressCity : String,
            AddressZip addressZip : String,
            AddressId addressId : String,
            Catergory category : Int,
            Cuisine cuisine : String,
            GroupSize groupSize : Int,
            BudgetPerPerson budget : Int,
            OrderMode orderMode :Int,
            RestsTried restsTried: String?
    ) {
        self.ddc_token = ddc_token
        self.searchAddress = searchAddress
        self.addressCity = addressCity
        self.addressZip = addressZip
        self.addressId = addressId
        self.category = category
        self.cuisine = cuisine
        self.groupSize = groupSize
        self.budget = budget
        self.orderMode = orderMode
        self.restsTried = restsTried
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
        
        let urlWithId:String = AppNetworkEndPoints.kOrder
        
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
                 "category": "\(self.category)",
                 "cuisine": self.cuisine,
                 "groupSize": "\(self.groupSize)",
                 "budget": self.budget,
                 "orderMode": self.orderMode
            ]
        
        if let restsTried = self.restsTried{
            body["restsTried"] = restsTried
        }
        
        return body
    }
}


