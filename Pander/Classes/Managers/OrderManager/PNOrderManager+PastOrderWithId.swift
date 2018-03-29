//
//  PNOrderManager+PastOrderWithId.swift
//  Pander
//
//  Created by Zeeshan on 29/03/2018.
//

import Foundation
import SwiftyJSON


extension PNOrderManager{
    
    //MARK: PastOrder/Method
    func getPastOrderWithID(OrderID orderid:String, SuccessBlock successBlock: @escaping ((_ successResponse: PNPastOrdersBaseClass ) -> Void),
                      FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
        let getOperation = PNPastOrderOperationWithID()
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNPastOrdersBaseClass{
                
                print("Success Reposne is",successResponse)
                
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

