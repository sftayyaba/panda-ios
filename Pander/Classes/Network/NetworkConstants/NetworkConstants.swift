//
//  NetworkConstants.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation

struct AppNetworkConstants {
    
   static let kBaseURLProductionString =   "https://www.pandereats.com/api/v2"
   static let kBaseURLTestingString =   "https://desolate-everglades-24260.herokuapp.com/api/v2"
   static let kBaseURLDevString =   "https://pandereats-unstable-dev.herokuapp.com/api/v2"
}

struct AppNetworkEndPoints {
    static let kUserLogin                           = "/login/"
    static let kUserSignUp                          = "/create/"
    static let kCreateGuestAccount                  = "/guest/"
    static let kConvertGuestUser                    = "/guest_convert/"
    static let kSignUpWithFacebook                  = "/auth/facebook/"
    static let kSignUpWithGoogle                    = "/auth/google/"
    static let kAddressSupported                    = "/address_supported/"
    static let kCheckEmail                          = "/check_email/"
    static let kRegisterUserForUpdates              = "/register/"
    static let kForgotPassword                      = "/forgot/"
    static let kReConfirmPassword                   = "/re_login/"
    static let kForgotDeliveryPassword              = "/user/ddc/forgot/"
    static let kVerifyCredentials                   = "/auth/"
    static let kGetRecommendations                  = "/user/recs/"
    static let kUpdateUserSetting                   = "/user/settings/"
    static let kUpdateTastePreferences              = "/user/prefs/"
    static let kUpdateDelivery                      = "/user/ddc/"
    static let kAddPushNotificationToken            = "/user/apn/"
    static let kDeletePushNotificationToken         = "/user/apn/"

}

struct AppNetworkStatusCodes {
    static let kNoInternerAccess                    = -1004;
}


struct AppNetworkStatusStrings {
    static let kSuccessStatus                       = "Success"
}
