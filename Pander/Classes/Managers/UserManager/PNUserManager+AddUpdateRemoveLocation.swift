//
//  PNUserManager+ForgotPassword.swift
//  Pander
//
//  Created by Shery on 16/01/2018.
//

import Foundation

extension PNUserManager{
    
    func updateLocation(LocationId locationId: String,
                     Street street: String,
                     Zip zip: String,
                     City city: String,
                     State state: String,
                     Phone phone: String,
                     UnitNumber unit_number: String,
                     NickName nickName: String?,
                     successBlock: @escaping ((_ locationAddResponse: PNDDCLocationResponseBaseClass) -> Void),
                     failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let apiOpertaion = PNUpdateAddressOperation(LocationId: locationId,
                                                  Street: street,
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
            
            if let response = response as? PNDDCLocationResponseBaseClass{
                
                if let nick = nickName{
                    
                    weakSelf?.addNicks(OfType: .address, Id: "\(response.location!.locationId!)", FriendlyName: nick, SuccessBlock: { (nickResponse) in
                        
                        successBlock(response)
                        
                    }, FailureBlock: { (error) in
                        failureBlock(error)
                    })
                    
                    
                }else{
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
            
            if let response = response as? PNDDCLocationResponseBaseClass{

                if let nick = nickName{

                    weakSelf?.addNicks(OfType: .address, Id: "\(response.location!.locationId!)", FriendlyName: nick, SuccessBlock: { (nickResponse) in
                        
                        successBlock(response)

                    }, FailureBlock: { (error) in
                        failureBlock(error)
                    })

                    
                }else{
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
    
    
    func removeLocation(LocationId locationId: String,
                     successBlock: @escaping ((_ locationAddResponse: PNDDCLocationResponseBaseClass) -> Void),
                     failureBlock: @escaping ((_ error: Error?) -> Void)){
        
        let apiOpertaion = PNRemoveAddressOperation( LocationId: locationId)
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        apiOpertaion.didFinishSuccessfullyCallback = {
            response in
            weakSelf?.notifyNetworkRequestFinish()
            
            if let response = response as? PNDDCLocationResponseBaseClass{
                
                successBlock(response)
                
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


