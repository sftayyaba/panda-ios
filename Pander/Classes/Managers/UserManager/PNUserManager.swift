//
//  JNUserManager.swift
//  JobsNow
//
//  Created by Shery on 15/11/2017.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import Alamofire
import PINCache
import SwiftyJSON

final class PNUserManager: PNBaseManager {
    
    // MARK: Instance Variables
    var isLoggedIn: Bool = false {
        didSet{

                let keyPath = "isLoggedIn"
                PINCache.shared().setObject(self.isLoggedIn as NSCoding, forKey: keyPath)
        }
    }
    
    var token:String?{
        didSet {
            if let token = self.token{
                let keyPath = "token"
                PINCache.shared().setObject(token as NSCoding, forKey: keyPath)
            }
        }
    }
    var email:String?{
        didSet {
            if let email = self.email{
                let keyPath = "email"
                PINCache.shared().setObject(email as NSCoding, forKey: keyPath)
            }
        }
    }
    
    
    
    
    var guestUser: PNCreateGuestAccount?{
        didSet {
            if let guestUser = self.guestUser{
                let keyPath = "guestUser"
                PINCache.shared().setObject(guestUser.dictionaryRepresentation() as NSCoding, forKey: keyPath)
            }
        }
    }
    
    var user: userBaseClass?{
        didSet {
            if let user = self.user{
                let keyPath = "user"
                PINCache.shared().setObject(user.dictionaryRepresentation() as NSCoding, forKey: keyPath)
            }
        }
    }
    
    
    var recommendations: PNRecommendationsModel?

    //Cards of user
    var cardsBaseObject: PNGetCardsBaseClass?
    var selectedCard: PNCards?
    
    //Addresses of user
    var addresses: [PNAddresses]?
    var selectedAddress: PNAddresses?
    //Nicks of User
    var userNicks: PNGetNicksResponse?
    //Defaults of User
    var userDefaults: PNUserDefaults?
    //Home Selected Cuisines
    var homeSelectedCuisines:[String]?
    
    var groupSize: Int = 1
    var budgetPerPerson: Int = 20
    
    //Selected Time And Date for order
    var selectedDate: String = "Today"
    var selectedTime: String = "ASAP"
    
    //step 1.1
    var selectedUnsupportedZip:String?
    var selectedZip:String?{
        didSet {
            if let selectedZip = self.selectedZip{
                let keyPath = "selectedZip"
                PINCache.shared().setObject(selectedZip as NSCoding, forKey: keyPath)
            }
        }
    }
    
    //step 1.2
    var selectedName:String?{
        didSet {
            if let selectedName = self.selectedName{
                let keyPath = "selectedName"
                PINCache.shared().setObject(selectedName as NSCoding, forKey: keyPath)
            }
        }
    }
    //step 2 & 3 recommendations
    var recommentations: PNRecommendationsModel?
    var allCuisines: PNAllCuisines?
    var allDishes: PNAllDishes?

    //step 2
    var selectedCusines :[String]?{
        didSet {
            if let selectedCusines = self.selectedCusines{
                let encodedCuisines = selectedCusines.map({ (json) -> String in
                    json
                })

                let keyPath = "selectedCusines"
                PINCache.shared().setObject(encodedCuisines as NSCoding, forKey: keyPath)
            }
        }
    }

    //step 3
    var selectedDishes :[String]?{
        didSet {
            if let selectedDishes = self.selectedDishes{
                let encodedDishes = selectedDishes.map({ (json) -> String in
                    json
                })
                
                let keyPath = "selectedDishes"
                PINCache.shared().setObject(encodedDishes as NSCoding, forKey: keyPath)
            }
        }
    }

    
    //step 4
    var isVegetarian : Bool = false
    var isVegan : Bool = false
    var isGlutenFree : Bool = false
    var isNoPeanut : Bool = false
    var isNoNuts : Bool = false
    var adventure : Int = 1

    
    static let sharedInstance: PNUserManager = {
        let instance = PNUserManager()
        
        if let token = PINCache.shared().object(forKey:"token") as? String{
            instance.token = token
        }
        
        if let email = PINCache.shared().object(forKey: "email") as? String{
            instance.email = email
        }
        
        if let selectedName = PINCache.shared().object(forKey:"selectedName") as? String{
            instance.selectedName = selectedName
        }
        
        if let selectedZip = PINCache.shared().object(forKey: "selectedZip") as? String{
            instance.selectedZip = selectedZip
        }

        
        
        if let userDictionary = PINCache.shared().object(forKey: "user"){
            instance.user = userBaseClass(object: userDictionary as AnyObject)
        }
        
        if let guestUser = PINCache.shared().object(forKey: "guestUser"){
            instance.guestUser = PNCreateGuestAccount(object: guestUser as AnyObject)
        }
        
        if let selectedCusines = PINCache.shared().object(forKey: "selectedCusines") as? [String]{
               instance.selectedCusines = selectedCusines
            
        }


        if let selectedDishes = PINCache.shared().object(forKey: "selectedDishes") as? [String]{
            instance.selectedDishes = selectedDishes
        }

        if let isLoggedIn = PINCache.shared().object(forKey: "isLoggedIn") as? Bool{
            instance.isLoggedIn = isLoggedIn
        }
        
        return instance
    }()
    

    //MARK: CallBacks
    override func notifyNetworkRequestStarted() {
        super.notifyNetworkRequestStarted()
    }
    
    override func notifyNetworkRequestFinish() {
        super.notifyNetworkRequestFinish()
    }
    
    
    func loginGuestUser(successBlock: @escaping (() -> Void), failureBlock: @escaping ((_ error: Error?) -> Void)){
        let loginGuestOperation = PNCreateGuestAccountOperation()
        
        weak var weakSelf = self
        
        weakSelf?.notifyNetworkRequestStarted()
        
        loginGuestOperation.didFinishSuccessfullyCallback = {
            response in
            
            if let guestUser = response as? PNCreateGuestAccount{
                weakSelf?.guestUser = guestUser
                weakSelf?.token = guestUser.accessTokenPander
                weakSelf?.email = guestUser.userId
            }

            weakSelf?.notifyNetworkRequestFinish()

            successBlock()
        }
        
        loginGuestOperation.didFinishWithErrorCallback = {
            error in

            weakSelf?.notifyNetworkRequestFinish()

            failureBlock(error)
        
        }
        
        OnebyteNetworkOperationQueue.sharedInstance.addOperation(loginGuestOperation)
        
    }
    
    
    func logoutUser(){
        
        PNUserManager.sharedInstance.selectedCard=nil;
        PNUserManager.sharedInstance.cardsBaseObject = nil;
        
        PNUserManager.sharedInstance.selectedAddress = nil;
        PNUserManager.sharedInstance.addresses=nil;

        PNUserManager.sharedInstance.selectedDishes = nil;
        PNUserManager.sharedInstance.selectedCusines = nil;
        
        PNUserManager.sharedInstance.homeSelectedCuisines = nil;
        
       // self.token = nil
        
        //self.email = nil
        
       // self.selectedName = nil
        
        
       // self.selectedZip = nil
    
       // self.user = nil
        
       // self.guestUser = nil
        
       // self.selectedCusines = nil
        
        
       // self.selectedDishes = nil
        
        //self.isLoggedIn = false
        //self.userNicks = nil

        PINCache.shared().removeAllObjects()
        
    }
}
