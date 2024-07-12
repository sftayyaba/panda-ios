//
//  PNOrderManager+AddToCart.swift
//  Pander
//
//  Created by umaid naeem on 3/8/18.
//

import Foundation
import SwiftyJSON

extension PNOrderManager{
    
    func AddToCartOrder(Items items : String,
                        ResturantId resturantId : String,
                           SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderBaseClass ) -> Void),
                           FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getOperation = PNAddToCartOperation(Items: items,ResturantId: resturantId)
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrderBaseClass{
                
                weakSelf?.placedOrderclear = successResponse
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
