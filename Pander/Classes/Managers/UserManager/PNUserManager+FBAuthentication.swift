//
//  PNUserManager+FBAuthentication.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager{
    
    func loginFBUser(FBToken fb_token: String , FBUserID fb_user_id: String , Email email: String, successBlock: @escaping (() -> Void), failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let connectWithFacebookOperation = PNConnectWithFacebookOperation(FBToken: fb_token, FBUserID: fb_user_id, Email: email)
   
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        connectWithFacebookOperation.didFinishSuccessfullyCallback = {
            response in

            weakSelf?.notifyNetworkRequestFinish()

            if let guestUser = response as? PNUserCommonSuccessResponse{
            
                weakSelf?.user = guestUser.user
                weakSelf?.token = guestUser.user?.accessTokenPander
                weakSelf?.email = guestUser.user?.email
                
                successBlock()
                
            }else if let errorResponse = response as? ErrorBaseClass{
                
                failureBlock(errorResponse)
            
            }
            
            
        }
        
        connectWithFacebookOperation.didFinishWithErrorCallback = {
            error in
            
            weakSelf?.notifyNetworkRequestFinish()
            
            failureBlock(error)
            
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(connectWithFacebookOperation)
        
    }
}
