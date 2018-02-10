//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {
    
    //MARK: CheckAddressIsSupported/Method
    func getAddresses(SuccessBlock successBlock: @escaping ((_ successResponse: PNGetAddressesResponse ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){

        let getAddressesOperation:PNGetAddressesOperation = PNGetAddressesOperation()
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        getAddressesOperation.didFinishSuccessfullyCallback = {
            response in
            weakSelf?.getNicks(SuccessBlock: { (nicks) in
                weakSelf?.getDefaults(SuccessBlock: { (defaults) in
                    
                    weakSelf?.notifyNetworkRequestFinish()
                    
                    if let successResponse = response as? PNGetAddressesResponse{
                        
                        successResponse.addresses = successResponse.addresses?.map({ (address) -> PNAddresses in
                            if let nick = nicks.addresses["\(address.locationId!)"]{
                                address.nick = nick
                            }
                            address.isSelected = defaults.address == "\(address.locationId!)"
                            address.isDefault = address.isSelected
                            
                            if ( weakSelf?.selectedAddress == nil && address.isSelected){
                                weakSelf?.selectedAddress = address
                            }
                            
                            return address
                        })
                        
                        weakSelf?.addresses = successResponse.addresses
                        
                        successBlock(successResponse)
                    }else if let errorResponse = response as? ErrorBaseClass{
                        failureBlock(errorResponse)
                    }
                    
                    
                }, FailureBlock: { (error) in
                    
                })
            }, FailureBlock: { (error) in
                
            })
            
        }
        
        getAddressesOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(getAddressesOperation)
    }

}


