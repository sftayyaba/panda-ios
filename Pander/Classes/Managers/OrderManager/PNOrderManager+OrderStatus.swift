//
//  PNOrderManager+GenerateOrder.swift
//  Pander
//
//  Created by Abdul Sami on 11/02/2018.
//

import Foundation

extension PNOrderManager{
    
    //MARK: GenerateOrder/Method
    func getGeneratedOrder(TaskId taskId : String,
                       SuccessBlock successBlock: @escaping ((_ successResponse: PNOrderBaseClass ) -> Void),
                       FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
        let getOperation = PNOrderStatusOperation(TaskId: taskId)
        
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()

            if let successResponse = response as? PNOrderBaseClass{
                
                weakSelf?.generatedOrder = successResponse
            weakSelf?.prevRestaurentIds.append(successResponse.recommendation!.restaurantInfo!.id!)
                
                successBlock(successResponse)
                
            }else if let errorResponse = response as? ErrorBaseClass{

                if let errorCode = errorResponse.code {
                    if errorCode == -3 || errorCode == -4{
                        
                        weakSelf?.notifyNetworkRequestStarted()

                        let deadlineTime = DispatchTime.now() + .seconds(1)
                        
                        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                            
                            weakSelf?.getGeneratedOrder(TaskId: taskId, SuccessBlock: successBlock, FailureBlock: failureBlock)

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

