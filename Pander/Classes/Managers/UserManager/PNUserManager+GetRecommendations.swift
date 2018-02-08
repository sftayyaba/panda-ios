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
            let getRecommendationsOperation = PNGetRecommendationsOperation(Location: "US" , Zip: self.selectedZip)
            
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
    
    
    func getAllCuisines(SuccessBlock successBlock: @escaping ((_ successResponse: PNAllCuisines ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        if let cachedRecommendations = self.allCuisines{
            successBlock(cachedRecommendations)
        }else{
            let getRecommendationsOperation = PNGetAllCuisinesOperation()
            
            weak var weakSelf = self
            
            weakSelf?.notifyNetworkRequestStarted()
            
            getRecommendationsOperation.didFinishSuccessfullyCallback = {
                response in
                
                weakSelf?.notifyNetworkRequestFinish()
                
                if let successResponse = response as? PNAllCuisines{
                    weakSelf?.allCuisines = successResponse
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
    
    func getAllDishes(SuccessBlock successBlock: @escaping ((_ successResponse: PNAllDishes ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        if let cachedRecommendations = self.allDishes{
            successBlock(cachedRecommendations)
        }else{
            let getRecommendationsOperation = PNGetAllDishesOperation()
            
            weak var weakSelf = self
            
            weakSelf?.notifyNetworkRequestStarted()
            
            getRecommendationsOperation.didFinishSuccessfullyCallback = {
                response in
                
                weakSelf?.notifyNetworkRequestFinish()
                
                if let successResponse = response as? PNAllDishes{
                    weakSelf?.allDishes = successResponse
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

