//
//  PNUserManager+ForgotPassword.swift
//  Pander
//
//  Created by Shery on 16/01/2018.
//

import Foundation

extension PNUserManager{
    
    func changePasswordWith(Email email: String, successBlock: @escaping (() -> Void), failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let apiOpertaion = PNForgotPasswordOperation(Email: email)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        apiOpertaion.didFinishSuccessfullyCallback = {
            response in
            weakSelf?.notifyNetworkRequestFinish()

            if (response as? PNCodeResponse) != nil{
                successBlock()
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

