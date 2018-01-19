//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func getRecommendationsForSelectedZip(SuccessBlock successBlock: @escaping ((_ successResponse: PNRecommendationsModel ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        if let cachedRecommendations = self.recommendations{
            successBlock(cachedRecommendations)
        }else{
            let getRecommendationsOperation = PNGetRecommendationsOperation(Location: "US" , Zip: self.selectedZip!)
            
            weak var weakSelf = self
            
            weakSelf?.notifyNetworkRequestStarted()
            
            getRecommendationsOperation.didFinishSuccessfullyCallback = {
                response in
                
                weakSelf?.notifyNetworkRequestFinish()
                
                if let successResponse = response as? PNRecommendationsModel{
                    weakSelf?.recommendations = successResponse
                    successBlock(successResponse)
                }else if let errorResponse = response as? ErrorBaseClass{
                    failureBlock(errorResponse)
                }
                
            }
            
            getRecommendationsOperation.didFinishWithErrorCallback = {
                error in
                weakSelf?.notifyNetworkRequestFinish()
                failureBlock(error)
            }
            
            OnebyteNetworkOperationQueue.sharedInstance.addOperation(getRecommendationsOperation)
        }
    }
}

