//
//  Constants.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/20/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults.standardUserDefaults()

let tipValues = [0.15, 0.2, 0.25]

struct NotifCenterConstants {
    static let ToggleNightMode = "toggle_night_mode"
}

struct UserDefaultsKeys {
    static let DefaultTip = "default_tip"
    static let LowLightActivated = "low_light_activated"
    static let BillSavedDateKey = "bill_saved_date_key"
    static let BillSavedAmountKey = "bill_saved_amount_key"
    static let BillSavedStringKey = "bill_saved_string_key"
}

struct AppColors {
    static let LightGreen = UIColor(red: 232.0/255.0, green: 255.0/255.0, blue: 233.0/255.0,  alpha: 1)
    static let DarkGreen = UIColor(red: 45.0/255.0, green: 103.0/255.0, blue: 41.0/255.0,  alpha: 1)
}
