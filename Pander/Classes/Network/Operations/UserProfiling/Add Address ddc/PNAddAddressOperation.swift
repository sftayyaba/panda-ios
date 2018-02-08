//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNAddAddressOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables

    public var street: String
    public var city: String
    public var state: String
    public var phone: String
    public var zipCode: String
    public var unit_number: String

    init(
        Street street: String,
        Zip zip: String,
        City city: String,
        State state: String,
        Phone phone: String,
        UnitNumber unit_number: String
        ) {
        self.street = street
        self.zipCode = zip
        self.city = city
        self.phone = phone
        self.state = state
        self.unit_number = unit_number
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startLoginOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        
        let json = JSON(response)
        
        let codeResponseObject: PNDDCLocationResponseBaseClass = PNDDCLocationResponseBaseClass(json: JSON(response))
        
        self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
        
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startLoginOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kAddAddress
        
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkDDCRequest(methodType: .post, path: urlWithId, parameters: createBody())).responseJSON {response in
             
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
        
        return [ "street"    : self.street,
                 "unit_number"     : self.unit_number,
                 "city"      : self.city,
                 "state"     : self.state,
                 "phone"     : self.phone,
                 "zip_code"  : self.zipCode,
        ]
    }
}
