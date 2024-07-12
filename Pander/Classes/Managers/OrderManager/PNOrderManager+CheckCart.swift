//
//  PNOrderManager+CheckCart.swift
//  Pander
//
//  Created by umaid naeem on 3/14/18.
//

import Foundation
import SwiftyJSON

extension PNOrderManager{
    
    func CheckCart(ResturantId resturantId : String,
                        SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderCheckCart ) -> Void),
                        FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getOperation = PNCheckCartOperation(ResturantId: resturantId)
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrderCheckCart{
                
//                weakSelf?.placedOrderclear = successResponse
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

