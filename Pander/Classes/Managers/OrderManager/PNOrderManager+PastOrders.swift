//
//  PNOrderManager+PastOrders.swift
//  Pander
//
//  Created by umaid naeem on 3/5/18.
//

import Foundation
import SwiftyJSON


extension PNOrderManager{
    
    //MARK: PastOrder/Method
    func getPastOrder(SuccessBlock successBlock: @escaping ((_ successResponse: PNPastOrdersBaseClass ) -> Void),
                           FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
        let getOperation = PNPastOrderOperation()
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNPastOrdersBaseClass{
                
                print("Success Reposne is",successResponse)
                
//                weakSelf?.pastOrders = successResponse.orders
                
                successBlock(successResponse)

            } else if let errorResponse = response as? ErrorBaseClass{
                    failureBlock(errorResponse)
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
