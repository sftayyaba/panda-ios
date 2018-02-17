//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {

    //MARK: CheckAddressIsSupported/Method
    func checkAddressIsSupported( Zip zip: String, SuccessBlock successBlock: @escaping ((_ successResponse: PNCodeResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        let checkAddressOperation = PNCheckAddressIsSupportedOperation(CountryCode: "US", Zip: zip)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        checkAddressOperation.didFinishSuccessfullyCallback = {
            response in

            weakSelf?.notifyNetworkRequestFinish()

            if let successResponse = response as? PNCodeResponse{
                weakSelf?.selectedZip = zip
                
                successBlock(successResponse)
            }else if let errorResponse = response as? ErrorBaseClass{
                weakSelf?.selectedUnsupportedZip = zip
                
                failureBlock(errorResponse)
            }
            
        }
        
        checkAddressOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(checkAddressOperation)
        
    }
    
    
    func registerForUpdates(Zip zip: String, Email email: String, CountryCode countryCode: String, SuccessBlock successBlock: @escaping ((_ successResponse: PNCodeResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        let checkAddressOperation = PNRegisterForUpdateOperation()
        checkAddressOperation.email = email;
        checkAddressOperation.zip = zip;
        checkAddressOperation.country_code = countryCode;
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        checkAddressOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNCodeResponse{
                weakSelf?.selectedZip = zip
                
                successBlock(successResponse)
            }else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }
            
        }
        
        checkAddressOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(checkAddressOperation)
        
    }
}
