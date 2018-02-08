//
//  PNUserManager+CheckAddressSupported.swift
//  Pander
//
//  Created by Abdul Sami on 12/01/2018.
//

import Foundation

extension PNUserManager {

    //MARK: UpdateTastePreferences/Method
    func updateTastePreferencesWith(SuccessBlock successBlock: @escaping ((_ successResponse: PNUpdateTastePreferences ) -> Void), FailureBlock failureBlock: @escaping ((_ error: Error?) -> Void)){
        let saveTasteOperation:PNSaveTasteOperation = PNSaveTasteOperation()
        
        
        saveTasteOperation.adventure       = self.adventure
        saveTasteOperation.vegan           = self.isVegan
        saveTasteOperation.vegetarian      = self.isVegetarian
        saveTasteOperation.peanuts         = self.isNoPeanut
        saveTasteOperation.nuts            = self.isNoNuts
        saveTasteOperation.gcm_id          = "safadfdfdfdf"
        
        var selectedCusinesString = ""

        if let cusinesArray = self.selectedCusines {

        for i in 0..<cusinesArray.count {
            
            selectedCusinesString = selectedCusinesString + "\(cusinesArray[i]),"
            
        }
        
        selectedCusinesString = "[" + selectedCusinesString.substring(to: selectedCusinesString.index(before: selectedCusinesString.endIndex)) + "]"
            
            saveTasteOperation.fav_cuisines    = selectedCusinesString

        }else {
            saveTasteOperation.fav_cuisines    = "[]"
        }
        
        if let zip = self.selectedZip {
            saveTasteOperation.zip             = zip
        }

        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        saveTasteOperation.didFinishSuccessfullyCallback = {
            response in

            weakSelf?.notifyNetworkRequestFinish()

            if let successResponse = response as? PNUpdateTastePreferences{
                successBlock(successResponse)
            }else if let errorResponse = response as? ErrorBaseClass{
                failureBlock(errorResponse)
            }
            
        }
        
        saveTasteOperation.didFinishWithErrorCallback = {
            error in
            weakSelf?.notifyNetworkRequestFinish()
            failureBlock(error)
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(saveTasteOperation)
        
    }
}
