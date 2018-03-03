//
//  PNOrderManager+OrderPlaced.swift
//  Pander
//
//  Created by Zeeshan on 04/03/2018.
//

import Foundation
import SwiftyJSON

extension PNOrderManager{

    func ClearPlacedOrders(ResturantId resturantId : String,
                           SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderBaseClass ) -> Void),
                           FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
        let getOperation = PNOrderOrderCartClear(ResturantId: resturantId)
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrderBaseClass{
                
                weakSelf?.placedOrderclear = successResponse
                if(successResponse.internalStatus != -1) {
                    weakSelf?.prevRestaurentIds.append(successResponse.recommendation!.restaurantInfo!.id!)
                    
                    successBlock(successResponse)
                }
                else {
                    weakSelf?.prevRestaurentIds.append("")
                    
                    successBlock(successResponse)
                }
            } else if let errorResponse = response as? ErrorBaseClass{
                
                if let errorCode = errorResponse.code {
                    if errorCode == -3 || errorCode == -4{
                        
                        weakSelf?.notifyNetworkRequestStarted()
                        
                        let deadlineTime = DispatchTime.now() + .seconds(1)
                        
                        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                            
                            weakSelf?.getGeneratedOrder(TaskId: resturantId, SuccessBlock: successBlock, FailureBlock: failureBlock)
                            
                            weakSelf?.notifyNetworkRequestFinish()
                            
                        }
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


