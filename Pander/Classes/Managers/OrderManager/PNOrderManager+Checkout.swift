//
//  PNOrderManager+Checkout.swift
//  Pander
//
//  Created by umaid naeem on 3/14/18.
//

import Foundation
import SwiftyJSON

extension PNOrderManager{
    
    func CheckOut(ResturantId resturantId : String,
                  LocationId locationId : String,
                  CardId cardId : String,
                  Tip tip : Double,
                  Instructions instructions : String,
                  SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderCheckout ) -> Void),
                  FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getOperation = PNCheckoutOperation(ResturantId: resturantId, LocationId: locationId, CardId: cardId, Tip: tip, Instructions: instructions)
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrderCheckout{
                
                weakSelf?.checkOut = successResponse
                successBlock(successResponse)
                
            } else if let errorResponse = response as? ErrorBaseClass{
                
                if let errorCode = errorResponse.code {
                    if errorCode == -3 || errorCode == -4{
                        
                        weakSelf?.notifyNetworkRequestStarted()
                        
                    }else{
                        failureBlock(errorResponse)
                    }
                }else{
                    failureBlock(errorResponse)
                }
            }
        }
        
        getOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(getOperation)
        
    }
    
}
