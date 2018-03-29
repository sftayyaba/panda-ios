//
//  PNOrderDetail.swift
//  Pander
//
//  Created by Aamir Nazir on 29/03/2018.
//

import UIKit

extension PNOrderManager{
    
    //MARK: PastOrder/Method
    func getPastOrderDetail(
        orderId: String,
        SuccessBlock successBlock: @escaping ((_ successResponse: PNOrders ) -> Void),
        FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)
        ){

        let getOperation = PNOrderDetailOperation(orderId: orderId)

        weak var weakSelf = self
        weakSelf?.notifyNetworkRequestStarted()

        getOperation.didFinishSuccessfullyCallback = {
            response in

            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNOrders {

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
