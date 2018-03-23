//
//  PNOrderManager+Edit&Reorder.swift
//  Pander
//
//  Created by umaid naeem on 3/6/18.
//

import Foundation


extension PNOrderManager{
    
    //MARK: GenerateOrder/Method
    func recreateOrder(SearchAddress searchAddress : String,
                       AddressCity addressCity : String,
                       AddressZip addressZip : String,
                       AddressId addressId : String,
                       ReorderInfo reorderInfo : String,
                       SuccessBlock successBlock: @escaping ((_ successResponse: PNGenerateOrder ) -> Void),
                       FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
//        let getRecommendationsOperation = PNOrderOperation(DDCToken: PNUserManager.sharedInstance.user!.ddcAccessToken!, SearchAddress: searchAddress, AddressCity: addressCity, AddressZip: addressZip, AddressId: addressId, Catergory: category, Cuisine: cuisine, GroupSize: groupSize, BudgetPerPerson: budget, OrderMode: orderMode, RestsTried: restsTried)
        
        
        let getRecommendationsOperation = PNEditReorderOperation(DDCToken: PNUserManager.sharedInstance.user!.ddcAccessToken!, SearchAddress: searchAddress, AddressCity: addressCity, AddressZip: addressZip, AddressId: addressId, ReorderInfo: reorderInfo)

        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getRecommendationsOperation.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let successResponse = response as? PNGenerateOrder{
                weakSelf?.generatedOrderId = successResponse.id
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
