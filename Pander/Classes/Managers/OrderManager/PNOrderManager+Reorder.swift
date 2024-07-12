//
//  PNOrderManager+Reorder.swift
//  Pander
//
//  Created by umaid naeem on 16/03/2018.
//

import Foundation

extension PNOrderManager{
    
    //MARK: GenerateOrder/Method
    func reOrder(OrderId orderId : String,
                       SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderBaseClass ) -> Void),
                       FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        let reorderOperation = PNReorderOperation(ReorderId: orderId)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        reorderOperation.didFinishSuccessfullyCallback = {
            response in
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrderBaseClass{
                
                successBlock(successResponse)
                
            } else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }

            
        }
        
        reorderOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(reorderOperation)
        
    }
    
    
}
