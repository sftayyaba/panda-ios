//
//  ApplicationConstants.swift
//  Expo Mobile
//
//  Created by Onebyte LLC on 6/9/17.
//  Copyright © 2017 Onebyte LLC. All rights reserved.
//

import Foundation
import UIKit

struct ApplicationStringConstants {
    // MARK: Navigation Bar
    static let kNavigationTitle = "Expo Mobile"
    static let kSearchTitle = "Search"
    static let kUserName = "Jane Doe"
    static let kUserMobileNumber = "(208)-555-5555"
    static let kUsageType = "Usage Type"
    static let kStartDate = "Start Date"
    static let kEndDate = "End Date"
    static let kcallNumber = "00000000000"
    static let kSelectedUsageType = "Select One"
    static let kUsageTypeTitle = "Issue Category"
    static let kBillingTitle = "Billing"
    static let kServiceTitle = "Service"
    static let kDeviceTitle  = "Device"
    static let kPortingTitle = "Porting"
    static let kNoDataTitle = "N/A"
    static let kDateFormate = "yyyy-MM-dd"
    static let kSmsTitle = ",WSMS"
    static let kVoiceTitle = "W611"
}

struct EMPayementHistoryTableViewConstants {
    // TODO: Put 'f' against floats
    
    static let kNumberOfSections = 1
    static let kInitialNumberOfRows = 25
    static let kSecondNumberOfRows = 0
    static let kHeightForHeaderRatio = 80.0
    static let kHeightForItemRow = 100.0
    static let kHeightForFooter = 0.0
}

struct EMSideMenuTableViewConstants {
    static let kNumberOfSections = 2
    static let kInitialNumberOfRows = 10
    static let kSecondNumberOfRows = 0
    static let kHeightForHeaderRatio = 190.0
    static let kHeightForTypeHeaderRow = 50.0
    static let kHeightForItemRow = 100.0
    static let kHeightForFooter = 0.0
    
    static let kTopSectionIndex = 0
    static let kHomeSectionIndex = 1
    static let kOrderLogsSectionIndex = 2
    
    static let kCurrentOrdersIndex = 0
}

struct ApplicationNumberConstants {
    // MARK: Navigation Bar
    static let kMenuBarButtonWidth = 30.0
    static let kMenuBarButtonHeight = 30.0
    
    static let kLeftBarButtonWidth = 30.0
    static let kLeftBarButtonHeight = 30.0

    static let kNavigationTitleImageWidth = 61.6
    static let kNavigationTitleImageHeight = 55.0

    // MARK: Side Menu
    static let kMenuRightPadding = 60
    static let kMenuRowCornerRadius = 10.0
    static let kMenuBackgroundAlphaComponent = 0.3
    static let kMenuBottomPadding = 60.0

    // MARK:UIControls
    static let kControlsBorderWidth = 0.5
    
    //MARK: Textfields
    static let kTextfieldCornerRadius = 10.0
    static let kTextfieldBorderWidth = 1.0
    static let kTextfieldLeftPadding = 4.0
    
    //MARK: TabBar
    static let kTabBarItemImageTopPadding : CGFloat = 6.0
}

struct ApplicationLocalArrays {
    // MARK: Side Menu
    static let kMenuOptions = ["Dashboard", "Refill", "Usage", "Logout"]
    static let kChangePlanOptions = ["PRICE","DATA", "TEXT", "VOICE"]
    static let kEditAccountOptions = ["EMAIL", "ADDRESS", "RESET PASSWORD"]

    static let kUsageTypeOptions = [
          ("1", "Data Only")
        , ("2", "Text Only")
        , ("3", "Voice Only")
        , ("4", "View All")
    ]

    static let kDummyPhoneNumbersOptions = [
        ("1", "(205) 456 9889")
        , ("2", "(205) 456 9819")
        , ("3", "(206) 456 9889")
        , ("4", "(205) 456 9883")
    ]
    
    static let kMonthOptions = [
        ("1", "January")
        , ("2", "February")
        , ("3", "March")
        , ("4", "April")
        , ("5", "May")
        , ("6", "June")
        , ("7", "July")
        , ("8", "August")
        , ("9", "September")
        , ("10", "October")
        , ("11", "November")
        , ("12", "December")
    ]
    
    static let kYearOptions = [
        ("1", "2017")
        , ("2", "2018")
        , ("3", "2019")
        , ("4", "2020")
        , ("5", "2021")
        , ("6", "2022")
        , ("7", "2023")
        , ("8", "2024")
        , ("9", "2025")
        , ("10", "2026")
        , ("11", "2027")
        , ("12", "2028")
        , ("13", "2029")
        , ("14", "2030")
    ]

    static let kStates = [ "AK",
                   "AL",
                   "AR",
                   "AS",
                   "AZ",
                   "CA",
                   "CO",
                   "CT",
                   "DC",
                   "DE",
                   "FL",
                   "GA",
                   "GU",
                   "HI",
                   "IA",
                   "ID",
                   "IL",
                   "IN",
                   "KS",
                   "KY",
                   "LA",
                   "MA",
                   "MD",
                   "ME",
                   "MI",
                   "MN",
                   "MO",
                   "MS",
                   "MT",
                   "NC",
                   "ND",
                   "NE",
                   "NH",
                   "NJ",
                   "NM",
                   "NV",
                   "NY",
                   "OH",
                   "OK",
                   "OR",
                   "PA",
                   "PR",
                   "RI",
                   "SC",
                   "SD",
                   "TN",
                   "TX",
                   "UT",
                   "VA",
                   "VI",
                   "VT",
                   "WA",
                   "WI",
                   "WV",
                   "WY"]
    
    static let kMenuOptionsImages = ["icon_home","icon_profile", "refill", "usage", "history", "support", "logout"]
    static let kIssueCategoryOptions = ["Billing","Service", "Device", "Porting"]
    static let kIssueSubCategoryOptions = [0: ["Auto Pay", "Refund", "Make Payement"],
                              1: ["Major Impact", "Medium Impact","Minor Impact"],
                              2: ["Programming","Re-provision"],
                              3: ["Edit","Submit","Check status"]
    ]
    
    static let kBillingOptions = [("", "Auto Pay")
        ,("", "Refund"),
         ("", "Make Payement")
    ]
    
    static let kServiceOptions = [
          ("", "Major Impact")
        , ("", "Medium Impact")
        , ("", "Monor Impact")
    ]
    static let kDeviceOptions = [
        ("", "Programming")
      , ("", "Re-Provision")
    ]
    static let kPortingOptions = [
        ("","Edit")
       ,("","Submit")
       ,("","Check Status")
    ]
    
    static let kNumberOfDays = 1 ... 30

}

struct ApplicationKeyStrings {
    // MARK: Caching
    static let kLoggedInCacheKey = "logged-in-cache-key"
    static let kDashboardCacheKey = "dashboard-cache-key"
    static let kCustomerCacheKey = "customer-cache-key"
    static let kMDNCacheKey = "mdn-number"
    static let kAllMDNCacheKey = "all-mdns"
}

struct ApplicationImageFilenames {
    // MARK: Navigation Bar
    static let kNavigationRightBarMenu = "hamburger-icon"
    static let kNavigationTitleImage = "navigation-logo"
    static let kNavigationLeftBarProfile = "user-icon"
    static let kNavigationBackButton = "back-icon"

    // MARK: Cells
    static let kMinusSelectedIcon = "minus-red-icon"
    static let kAddUnselectedIcon = "add-icon"
}

struct ApplicationDatasourceFilenames {
    // MARK: Offline JSON
}

struct ApplicationInterfaceFilenames {
    static let kLoginViewController = "EMLoginView"
    
    static let kChangePasswordViewController = "EMChangePasswordView"

    static let kForgotPasswordViewController = "EMForgotPasswordView"
    
    static let kDashboardViewController = "EMDashboardView"
    
    static let kAccountsViewController = "EMAccountsView"

    static let kEditAccountViewController = "EMEditAccountView"
    static let kEditAccountHeaderTableViewCell = "EMEditAccountHeaderTableViewCell"
    static let kEditAddressTableViewCell = "EMEditAddressTableViewCell"
    static let kEditPaymentTableViewCell = "EMEditPaymentTableViewCell"
    static let kEditEmailTableViewCell = "EMEditEmailTableViewCell"
    static let kEditPasswordTableViewCell = "EMEditPasswordTableViewCell"

    static let kUsageViewController = "EMUsageView"
    static let kUsageCustomCellTableViewCell = "EMUsageCustomTableViewCell"
    static let kUsageTopScetionTableViewCell = "EMUsageTopSectionTableViewCell"
    static let kUsageCustomHeaderTableViewCell = "EMUsageCustomHeaderTableViewCell"

    static let kRefillViewController = "EMRefillView"

    static let kPayementHistoryViewController = "EMPayementHistoryView"
    static let kPayementHistoryHeaderTableViewCell = "EMPayementHistoryHeaderTableViewCell"
    static let kPayementHistoryTableViewCell = "EMPayementHistoryTableViewCell"

    static let kSupportViewController = "EMSupportView"

    static let kChangePlanViewController = "EMChangePlanView"
    static let kChangePlanHeaderTableViewCell = "EMChangePlanHeaderTableViewCell"
    static let kChangePlanRowTableViewCell = "EMChangePlanRowTableViewCell"
    
    static let kChangePlanCategoriesRowTableViewCell = "EMChangePlanCategoriesTableViewCell"

    static let kMessagesViewController = "EMMessagesView"
    static let kMessagesHeaderTableViewCell = "EMMessagesHeaderTableViewCell"
    static let kMessagesRowTableViewCell = "EMMessagesRowTableViewCell"

    static let kAddMoreViewController = "EMAddMoreView"
    static let kAddMoreHeaderTableViewCell = "EMAddMoreHeaderTableViewCell"
    static let kAddMoreRowTableViewCell = "EMAddMoreRowTableViewCell"
    
    static let kCalenderViewController = "CalendarPopUp"

    static let kReportAnIssueViewController = "EMReportAnIssueView"
    
    static let kUpgradePlanViewController = "EMUpgradePlanView"

    static let kCreditCardViewController = "EMCreditCardView"

    static let kChangePlanCategoriesViewController = "EMChangePlanCategoriesView"

    static let kSideMenuViewController = "EMSideMenuView"
    static let kSideMenuItemTableViewCell = "EMSideMenuItemTableViewCell"
}

struct ApplicationAlertMessages {
    // MARK: Common
    static let kAlertTitle = "Alert"
    static let kAlertCancelTitle = "Cancel"
    static let kAlertDoneTitle = "Done"
    static let kAlertYesTitle = "Yes"
    static let kAlertMessageTitle = "Are You Sure"
    static let kAlertDateMessageTitle = "Please enter correct date"
    static let kAlertInternetNotAvailableTitle = "Internet not available!"
    static let kAlertSelectUsageTypeTitle = "Select UsageType"
    static let kAlertSelectCorrectDateTitle = "Please enter correct date"
}

struct StringConstants {
    static let restaurantNamePlaceholder = "{{RESTAURANT NAME}}"
    static let orderCheckoutSuccessMessage = "Thanks for your order from {{RESTAURANT NAME}}! They're working on it now for you to enjoy - in the meantime, here's a summary and some contact information in case you need anything."
}
