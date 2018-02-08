//
//  PNUserManager+ForgotPassword.swift
//  Pander
//
//  Created by Shery on 16/01/2018.
//

import Foundation

extension PNUserManager{
    
    func addLocation(Street street: String,
                     Zip zip: String,
                     City city: String,
                     State state: String,
                     Phone phone: String,
                     UnitNumber unit_number: String,
                     NickName nickName: String?,
                     successBlock: @escaping ((_ locationAddResponse: PNDDCLocationResponseBaseClass) -> Void),
                     failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let apiOpertaion = PNAddAddressOperation( Street: street,
                                                  Zip: zip,
                                                  City: city,
                                                  State: state,
                                                  Phone: phone,
                                                  UnitNumber: unit_number)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        apiOpertaion.didFinishSuccessfullyCallback = {
            response in
            weakSelf?.notifyNetworkRequestFinish()
            
            if (response as? PNDDCLocationResponseBaseClass) != nil{
                successBlock(response as! PNDDCLocationResponseBaseClass)
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


