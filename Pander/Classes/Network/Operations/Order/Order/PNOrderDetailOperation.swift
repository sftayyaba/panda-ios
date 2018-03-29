//
//  PNOrderDetailOperation.swift
//  Pander
//
//  Created by Aamir Nazir on 29/03/2018.
//

import UIKit
import SwiftyJSON

class PNOrderDetailOperation: OnebyteNetworkOperationBase {
    
    
    //MARK: Instance Variables
    
    var orderId : String
    
    init(orderId: String) {
        self.orderId = orderId
    }

    //MARK: Overridden Methods
    override func start() {
        super.start()

        startOrderDetailOperation()
    }

    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let json = JSON(response)
        if let code = json["code"].int{
            if code >= PNApiResponseCodes.successResponse.rawValue, let orderJson = json["order"].dictionary {
                let codeResponseObject = PNOrders(json: JSON(orderJson))
                self.safeCallDidFinishSuccessfullyCallback(responseObject: codeResponseObject)
            }else if code <= PNApiResponseCodes.errorResponse.rawValue{
                let errorResponse: ErrorBaseClass = ErrorBaseClass(json: JSON(response))
                self.safeCallDidFinishSuccessfullyCallback(responseObject: errorResponse)
            }
        }

        self.handleDidFinishedCommon()
    }

    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }

    //MARK: Request
    private func startOrderDetailOperation() {
        let urlWithId:String = AppNetworkEndPoints.kPastOrderDetail.replacingOccurrences(of: "{{order_id}}", with: orderId)
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkRequest(methodType: .get, path: urlWithId, parameters: nil)).responseJSON {response in

            if ((response.response?.statusCode) == 200){
                switch response.result {
                case .success(let data):
                    self.handleDidFinishedWithResponse(response: data as AnyObject!)
                    break
                case .failure(let error):
                    self.handleDidFinishedWithError(error: error)
                    break
                }
            } else {
                self.handleDidFinishedWithError(error: response.error)
            }
        }
    }
}
