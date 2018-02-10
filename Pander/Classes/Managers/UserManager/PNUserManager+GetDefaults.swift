//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func getDefaults(SuccessBlock successBlock: @escaping ((_ successResponse: PNUserDefaults ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getAddressesOperation:PNGetDefaultsOperation = PNGetDefaultsOperation()
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getAddressesOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNUserDefaults{
                weakSelf?.userDefaults = successResponse
                successBlock(successResponse)
            }else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }
            
        }
        
        getAddressesOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(getAddressesOperation)
    }
    
}




