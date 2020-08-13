//
//  Constants.swift
//  ABC Vehicle Servicing
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.

import Foundation
import UIKit
/// File to store constants which are used across the app

// constants for User Defaults
let kLoginIsRemember    = "isRemember"
let kUserLogin          = "isLogin"
let kUserId             = "User_ID"
let kMD5Password        = "userPassword"
let kFullName           = "fullName"
// enums for log category
enum logCategory: Int
{
    case ui = 0,
    network,
    database
}

// enums for log level privacy
enum logLevel: Int
{
    case publicLevel = 0,
    privateLevel
}


enum slideOutState: Int {
  case collapsed = 0,
  leftPanelExpanded
}


enum vehicleTransmission: Int {
    case vehicle_trans_manual = 0,
    vehicle_trans_automatic
}


// enums for localisation
enum LocalizationKey: String {
    // enum value = Key of string
    case timeout_str = "TIMEOUT_STR"
    case welcome_str = "WELCOME_STR"
    case login_str = "LOGIN_STR"
    case emailid_str = "EMAILID_STR"
    case email_place_str = "EMAIL_PLACE_STR"
    case pass_str = "PASS_STR"
    case pass_place_str = "PASS_PLACE_STR"
    case remember_me_str = "REMEMBER_ME_STR"
    case forgot_pass_str = "FORGOT_PASS_STR"
    case or_str = "OR_STR"
    case email_empty_str = "EMAIL_EMPTY_STR"
    case email_notvalid_str = "EMAIL_NOT_VALID_STR"
    case pass_empty_str = "PASS_EMPTY_STR"
    case pass_notvalid_str = "PASS_NOT_VALID_STR"
    case passcode_use_str = "PASSCODE_USE_STR"
    case passcode_req_str = "PASSCODE_REQ_STR"
    case something_wrong_str = "SOMETHING_WRONG_STR"
    case auth_success_str =  "AUTH_SUCCESS_STR"
    case logout_str = "LOGOUT_STR"
    case google_sign_issue_str = "GOOGLE_SIGN_ISSUE_STR"
    case logout_conf_str = "LOGOUT_CONF_STR"
    case vehicle_status_str = "VEHICLE_STATUS_STR"
    case update_status_str = "UPDATE_STATUS_STR"
    case update_msg_str = "UPDATE_MSG_STR"
    case status_empty_str = "STATUS_EMPTY_STR"

    
    case alert_title_fail = "ALERT_TITLE_FAIL"
    case alert_title_error = "ALERT_TITLE_ERROR"
    case alert_ok = "ALERT_OK"
    case alert_title_success = "ALERT_TITLE_SUCCESS"
    case alert_title_confirmation = "ALERT_TITLE_CONFIRMATION"
    case alert_yes = "ALERT_YES"
    case alert_no = "ALERT_NO"
    
    
    case img_splash_main = "SPLASH_MAIN_IMG"
    case img_splash = "SPLASH_IMG"
    case img_google_login = "GICON_LOGIN_IMG"
    case img_menu = "MENU_IMG"
    case img_notification = "NOTIFICATION_IMG"
    case img_updates_status = "UPDATE_STATUS_IMG"
    
    var string: String {
        return rawValue.localized()
    }
}


struct vehicleItem {
    var vehicleName: String?
    var vehicleImage: String?
    var vehicleKM: String?
    var vehicleSeatCap:  String?
    var vehicleFuel: String?
    var vehicleTrans: vehicleTransmission?
}



let kBackgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) // white
let kBrandColor = UIColor.init(red: 75.0/255.0, green: 169.0/255.0, blue: 205.0/255.0, alpha: 1.0)
let kCustomGreyColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)


let TIMEOUT_API = 60.0

let API_URL = ""
let GOOGLE_CLIENT_ID = "681109074889-e54t29usie7ttuq654p4m1dt81t6vhbp.apps.googleusercontent.com"
