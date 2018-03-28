//
//  NetworkConstants.swift
//  expomobile-swift
//
//  Created by Onebyte LLC on 12/06/2017.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation

struct AppNetworkConstants {
    static let kBaseURLDevString =   "https://desolate-everglades-24260.herokuapp.com/api/v2"

    static let kBaseURLProductionString =   "https://www.pandereats.com/api/v2"
    static let kBaseURLTestingString =  "https://desolate-everglades-24260.herokuapp.com/api/v2"
   
    static let kBaseDDCURLString =  "https://api.delivery.com"
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
    static let kGetAllCuisines                      = "/all_cuisines/"
    static let kGetAllDishes                        = "/all_dishes/"
    static let kGetAllCards                         = "/user/cards/"
    static let kGetAllAddresses                     = "/user/addresses/"
    static let kGetUserNicks                        = "/user/nicknames/"
    static let kGetUserDefaults                     = "/user/defaults/"
    static let kAddUserDefaults                     = "/user/defaults/"
    static let kAddNicks                            = "/user/nicknames/"
    
    static let kOrder                               = "/order/"
    static let kOrderStatus                         = "/order/status/"
    static let kPastOrder                           = "/user/orders/"
    static let kEditAndReorder                      = "/order/recreate/"
    static let KOrderPlaced                         = "/order/placed/"
    static let KOrderRated                          = "/order/rated/"
    static let KOrderFeedback                       = "/order/feedback/"
    static let kOrderReOrder                        = "/order/reorder/"
    static let KorderReCreate                       = "/order/recreate/"
    static let KOrderCartClear                      = "/order/cart/clear/"
    static let KOrderCartAdd                        = "/order/cart/add/"
    static let KOrderCartCheck                      = "/order/cart/check/"
    static let KOrderCartCheckOut                   = "/order/cart/checkout/"
    static let kAddAddress                          = "/customer/location/"
    static let kAddCreditCard                       = "/customer/cc/"
    static let kmerchantOrders                      = "/merchant/hours/"
    static let kMerchantHours                       = "/merchant/88630/hours/"
}

struct AppNetworkStatusCodes {
    static let kNoInternerAccess                    = -1004;
}


struct AppNetworkStatusStrings {
    static let kSuccessStatus                       = "Success"
}
