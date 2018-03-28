//
//  MerchantHoursOperation.swift
//  Pander
//
//  Created by Aamir Nazir on 27/03/2018.
//

import UIKit

class MerchantHoursOperation: OnebyteNetworkOperationBase {

    //MARK: Overridden Methods
    override func start() {
        super.start()
        self.startMerchantHoursOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        
        if let jsonDict = response as? [String : Any] {
            let merchantHoursObject = MerchantHoursModel(JSON: jsonDict)
            self.safeCallDidFinishSuccessfullyCallback(responseObject: merchantHoursObject)
        }

        self.handleDidFinishedCommon()
    }

    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }

    //MARK: Request
    private func startMerchantHoursOperation() {
        
        let urlWithId = AppNetworkEndPoints.kMerchantHours

        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkDDCRequest(methodType: .get, path: urlWithId, parameters: nil)).responseJSON {response in

            if ((response.response?.statusCode) == 200){
                switch response.result {
                case .success(let data):
                    self.handleDidFinishedWithResponse(response: data as AnyObject!)
                    break
                case .failure(let error):
                    self.handleDidFinishedWithError(error: error)
                    break
                }
            }else{
                self.handleDidFinishedWithError(error: response.error)
            }
        }
    }
}
