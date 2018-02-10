//
//  PNUserManager+ForgotPassword.swift
//  Pander
//
//  Created by Shery on 16/01/2018.
//

import Foundation

extension PNUserManager{
    
    func addCreditCard(CardNumber cardNumber: String,
                     Zip zip: String,
                     Year year: String,
                     ClientId id: String,
                     Cvv cvv: String,
                     Month month: String,
                     NickName nickName: String?,
                     successBlock: @escaping ((_ locationAddResponse: PNAddCardResponse) -> Void),
                     failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let apiOpertaion = PNAddPaymentOperation(CardNumber: cardNumber, Zip: zip, Year: year, ClientId: id, Cvv: cvv, Month: month)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        apiOpertaion.didFinishSuccessfullyCallback = {
            response in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            if let response = response as? PNAddCardResponse{
                if let nickName = nickName{
                    weakSelf?.addNicks(OfType: PNNickOperationType.card, Id: "\(response.ccId!)", FriendlyName: nickName, SuccessBlock: { (nickResponse) in
                        successBlock(response)

                    }, FailureBlock: { (error) in
                        failureBlock(error)
                    })
                }
                else{
                    successBlock(response)
                }
            }else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }
        }
        
        apiOpertaion.didFinishWithErrorCallback = {
            error in
            
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
            
        }
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(apiOpertaion)
    }
}


