 //
 //  PNUserManager+CheckAddressSupported.swift
 //  Pander
 //
 //  Created by Abdul Sami on 12/01/2018.
 //
 
 import Foundation
 
 extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func signIn( Email email: String, Password password: String, SuccessBlock successBlock: @escaping ((_ successResponse: PNUserCommonSuccessResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        
            let signUpOperation = PNVerifyCredentialsOperation()
        
        signUpOperation.email = email
        signUpOperation.password = password
        
            weak var weakSelf = self
            
            weakSelf?.notifyNetworkRequestStarted()
            
            signUpOperation.didFinishSuccessfullyCallback = {
                response in
                
                weakSelf?.notifyNetworkRequestFinish()
                
                if let successResponse = response as? PNUserCommonSuccessResponse{
                    
                    weakSelf?.email = successResponse.user?.email
                    weakSelf?.token = successResponse.user?.accessTokenPander
                    
                    weakSelf?.user = successResponse.user
                    
                    weakSelf?.isLoggedIn = true
                    
                    successBlock(successResponse)
                }else if let errorResponse = response as? ErrorBaseClass{
                    failureBlock(errorResponse)
                }
                
            }
            
            signUpOperation.didFinishWithErrorCallback = {
                error in
                weakSelf?.notifyNetworkRequestFinish()
                failureBlock(error)
            }
            
            OnebyteNetworkOperationQueue.sharedInstance.addOperation(signUpOperation)
            
        
        
    }
 }
 

