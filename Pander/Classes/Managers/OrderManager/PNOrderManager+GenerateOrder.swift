//
//  PNOrderManager+GenerateOrder.swift
//  Pander
//
//  Created by Abdul Sami on 11/02/2018.
//

import Foundation

extension PNOrderManager{
    
    //MARK: GenerateOrder/Method
    func generateOrder(SearchAddress searchAddress : String,
                       AddressCity addressCity : String,
                       AddressZip addressZip : String,
                       AddressId addressId : String,
                       Catergory category : Int,
                       Cuisine cuisine : String,
                       GroupSize groupSize : Int,
                       BudgetPerPerson budget : Int,
                       OrderMode orderMode :Int,
                       RestsTried restsTried: String?,
                       SuccessBlock successBlock: @escaping ((_ successResponse: PNGenerateOrder ) -> Void),
                       FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        
        
        let getRecommendationsOperation = PNOrderOperation(DDCToken: PNUserManager.sharedInstance.user!.ddcAccessToken!, SearchAddress: searchAddress, AddressCity: addressCity, AddressZip: addressZip, AddressId: addressId, Catergory: category, Cuisine: cuisine, GroupSize: groupSize, BudgetPerPerson: budget, OrderMode: orderMode, RestsTried: restsTried)
        
            
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
