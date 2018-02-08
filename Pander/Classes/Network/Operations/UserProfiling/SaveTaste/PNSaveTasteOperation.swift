//
//  LoginOperation.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

class PNSaveTasteOperation: OnebyteNetworkOperationBase {
    
    //MARK: Instance Variables
    var adventure:Int?
    var fav_cuisines:String?
    var vegan:Bool?
    var vegetarian:Bool?
    var peanuts:Bool?
    var nuts:Bool?
    var zip:String?
    var gcm_id:String?
    
    //MARK: Overridden Methods
    override func start() {
        super.start()
        
        self.startUpdateTastePreferencesOperation()
    }
    
    override func handleDidFinishedWithResponse(response: AnyObject!) {
        let updateTaste: PNUpdateTastePreferences = PNUpdateTastePreferences(json: JSON(response))
        
        self.safeCallDidFinishSuccessfullyCallback(responseObject: updateTaste)
        self.handleDidFinishedCommon()
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    //MARK: Request
    private func startUpdateTastePreferencesOperation() {
       
        let urlWithId:String = AppNetworkEndPoints.kUpdateTastePreferences
        OnebyteNetworkSessionManager.request(AppNetworkManager.closeNetworkRequest(methodType: .post, path: urlWithId, parameters: self.createBody())).responseJSON {response in
            
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
    
    private func createBody() -> Dictionary<String, Any>{
        return [
            "adventure": self.adventure!,
            "fav_cuisines": self.fav_cuisines!,
            "vegan": self.vegan!,
            "vegetarian": self.vegetarian!,
            "peanuts": self.peanuts!,
            "nuts": self.nuts!,
            "zip": self.zip!,
            "gcm_id":self.gcm_id!
        ]
    }
}
