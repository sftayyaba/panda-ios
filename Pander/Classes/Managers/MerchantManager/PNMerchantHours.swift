//
//  PNMerchantHours.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit
import SwiftyJSON

extension PNMerchantManager{

    //MARK: PastOrder/Method
    func getMerchantHours(
        SuccessBlock successBlock: @escaping ((_ successResponse: MerchantHoursModel ) -> Void),
        FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)
        ) {
        let merchantHoursOperation = MerchantHoursOperation()
        weak var weakSelf = self

        weakSelf?.notifyNetworkRequestStarted()

        merchantHoursOperation.didFinishSuccessfullyCallback = {
            response in

            weakSelf?.notifyNetworkRequestFinish()

            if let successResponse = response as? MerchantHoursModel{

                print("Success Reposne is",successResponse)

                successBlock(successResponse)
            } else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }
        }

        merchantHoursOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }

        OnebyteNetworkOperationQueue.sharedInstance.addOperation(merchantHoursOperation)
    }
}
