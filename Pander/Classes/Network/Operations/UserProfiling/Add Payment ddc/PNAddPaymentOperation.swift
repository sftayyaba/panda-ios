//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNAddPaymentOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables

    public var cardNumber: String
    public var cvv: String
    public var month: String
    public var year: String
    public var zipCode: String
    public var client_id: String

    init(
        CardNumber cardNumber: String,
        Zip zip: String,
        Year year: String,
        ClientId id: String,
        Cvv cvv: String,
        Month month: String
        ) {
        self.cardNumber = cardNumber
        self.zipCode = zip
        self.year = year
        self.month = month
        self.cvv = cvv
        self.client_id = id
    }
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startLoginOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        
        let json = JSON(response)
        
        let codeResponseObject: PNAddCardResponse = PNAddCardResponse(json: json)
        if codeResponseObject.message?.count == 0{
            
            self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
        }else{
            self.safeCallDidFinishWithErrorCallback(error: codeResponseObject.message?.first)

        }
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startLoginOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kAddCreditCard
        
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
        
        return [ "cc_number"    : self.cardNumber,
                 "exp_month"     : self.month,
                 "exp_year"      : self.year,
                 "cvv"     : self.cvv,
                 "client_id"     : self.client_id,
                 "billing_zip"  : self.zipCode,
        ]
    }
}
