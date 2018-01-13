//
//  JNUserManager.swift
//  JobsNow
//
//  Created by Shery on 15/11/2017.
//  Copyright © 2017 iDevz. All rights reserved.
//

import Foundation
import Alamofire

final class PNUserManager: PNBaseManager {
    
    // MARK: Instance Variables
    var token:String?
    var email:String?
    
    var guestUser: PNCreateGuestAccount?
    var user: userBaseClass?
    
    var recommendations: PNRecommendationsModel?
    
    //step 1.1
    var selectedZip:String?
    //step 1.2
    var selectedName:String?
    
    
    
    static let sharedInstance: PNUserManager = {
        let instance = PNUserManager()
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
    
    //MARK: - Operation -
//
//    //MARK: Operation/Login
//    func loginUserWith(email:String, password: String,successBlock: @escaping (() -> Void), failureBlock: @escaping ((_ error: Error?) -> Void)) {
//
//        let loginOperation: JNLoginOperation = JNLoginOperation()
//
//        loginOperation.email = email
//        loginOperation.password = password
//
//        weak var weakSelf = self
//
//        weakSelf?.notifyNetworkRequestStarted()
//
//        loginOperation.didFinishSuccessfullyCallback = { response in
//
//            successBlock()
//            weakSelf?.handleLoginSuccessfulAPIRequest(response: response)
//        }
//
//        loginOperation.didFinishWithErrorCallback = { error in
//            failureBlock(error)
//            weakSelf?.handleLoginFailedAPIRequest(error: error)
//        }
//
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(loginOperation)
//    }
//
//    //MARK: Operation/ForgotPassword
//    func handleForgotPasswordAPIRequest (email: String, successBlock: @escaping (()-> Void), failureBlock: @escaping (()->Void)) {
//
//        let resetPassword: JNForgotPasswordOperation = JNForgotPasswordOperation()
//
//        resetPassword.email = email
//
//        weak var weakSelf = self
//
//        resetPassword.didFinishSuccessfullyCallback = { response in
//            successBlock()
//            weakSelf?.handleForgotPasswordSuccessfulAPIRequest(response: response)
//        }
//
//        resetPassword.didFinishWithErrorCallback = { error in
//            failureBlock()
//            weakSelf?.handleForgotPasswordFailedAPIRequest(error: error)
//        }
//
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(resetPassword)
//    }
//
//    //MARK: Operation/UpdatePassword
//    func handleUpdatePasswordAPIRequest(newPassword:String!, oldPassword: String!,successBlock: @escaping (()-> Void), failureBlock: @escaping (()->Void)) {
//
//        let updatePasswordOperation:JNUpdatePasswordOperation = JNUpdatePasswordOperation()
//        updatePasswordOperation.newPassword = newPassword
//        updatePasswordOperation.oldPassword = oldPassword
//
//         weak var weakSelf = self
//
//        updatePasswordOperation.didFinishSuccessfullyCallback = { response in
//            successBlock()
//            weakSelf?.handleUpdatePasswordSuccessfulAPIRequest(response: response)
//        }
//
//        updatePasswordOperation.didFinishWithErrorCallback = { error in
//            failureBlock()
//            weakSelf?.handleUpdatePasswordFailedAPIRequest(error: error)
//        }
//
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(updatePasswordOperation)
//    }
//
//    //MARK: Operation/JoiningCode
//    func handleJoiningCodeAPIRequest(successBlock: @escaping (()-> Void), failureBlock: @escaping ((_ error: Error?)->Void)) {
//
//        let updatePasswordOperation:JNJoiningCodesOperation = JNJoiningCodesOperation()
//
//        weak var weakSelf = self
//
//        updatePasswordOperation.didFinishSuccessfullyCallback = { response in
//            successBlock()
//            weakSelf?.handleJoiningCodeSuccessfulAPIRequest(response: response)
//        }
//
//        updatePasswordOperation.didFinishWithErrorCallback = { error in
//            failureBlock(error)
//            weakSelf?.handleJoiningCodeFailedAPIRequest(error: error)
//        }
//
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(updatePasswordOperation)
//    }
//
//    //MARK: Operation/UpdatingProfile
//    func handleUpdatingProfileAPIRequest(userName:String!, profilePicture: String!,successBlock: @escaping (()-> Void), failureBlock: @escaping ((_ error: Error?)->Void)) {
//
//        let updateProfileOperation:JNUpdateProfileOperation = JNUpdateProfileOperation()
//
//        updateProfileOperation.userName = userName
//        updateProfileOperation.pictureUrl = profilePicture
//        weak var weakSelf = self
//
//        updateProfileOperation.didFinishSuccessfullyCallback = { response in
//            successBlock()
//            weakSelf?.handleUpdatingProfileSuccessfulAPIRequest(response: response)
//        }
//
//        updateProfileOperation.didFinishWithErrorCallback = { error in
//            failureBlock(error)
//            weakSelf?.handleUpdatingProfileFailedAPIRequest(error: error)
//        }
//
//        OnebyteNetworkOperationQueue.sharedInstance.addOperation(updateProfileOperation)
//    }
//
//    // MARK: - Events -
//    // MARK: Events/Login
//    private func handleLoginSuccessfulAPIRequest(response : AnyObject!) -> Void {
//
//        let userObject = (response as! JNLoginResponseModel)
//
//        self.token = userObject.token
//        self.user = userObject.user
//
//        self.notifyNetworkRequestFinish()
//    }
//
//    private func handleLoginFailedAPIRequest(error : Error!) -> Void {
//        self.notifyNetworkRequestFinish()
//    }
//
//    // MARK: Events/ForgotPassword
//    func handleForgotPasswordSuccessfulAPIRequest(response: AnyObject!) {
//
//    }
//
//    func handleForgotPasswordFailedAPIRequest (error:Error!){
//
//    }
//
//    // MARK: Events/UpdatePassword
//    func handleUpdatePasswordSuccessfulAPIRequest (response: AnyObject!) {
//
//    }
//
//    func handleUpdatePasswordFailedAPIRequest (error: Error!) {
//
//    }
//
//    // MARK: Events/JoiningCode
//    func handleJoiningCodeSuccessfulAPIRequest (response: AnyObject!) {
//        JNUserManager.joiningCodeObject = (response as! JNJoiningCodesBaseClass)
//    }
//
//    func handleJoiningCodeFailedAPIRequest (error: Error!) {
//
//    }
//
//    // MARK: Events/UpdatingProfile
//    func handleUpdatingProfileSuccessfulAPIRequest (response: AnyObject!) {
//    }
//
//    func handleUpdatingProfileFailedAPIRequest (error: Error!) {
//    }
}
