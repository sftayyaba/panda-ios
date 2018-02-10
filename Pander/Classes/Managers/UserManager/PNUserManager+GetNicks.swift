//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func getNicks(SuccessBlock successBlock: @escaping ((_ successResponse: PNGetNicksResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getAddressesOperation:PNGetNicksOperation = PNGetNicksOperation()
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getAddressesOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNGetNicksResponse{
                weakSelf?.userNicks = successResponse
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
 
    
    
    func addNicks(OfType type: PNNickOperationType, Id id: String, FriendlyName friendlyName: String, SuccessBlock successBlock: @escaping ((_ successResponse: PNGetNicksResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let getAddressesOperation:PNAddNickOperation = PNAddNickOperation(OfType: type,Id: id, FriendlyName:  friendlyName)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getAddressesOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNGetNicksResponse{
                weakSelf?.userNicks = successResponse
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




