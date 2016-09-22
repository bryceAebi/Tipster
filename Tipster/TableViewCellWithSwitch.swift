//
//  TableViewCellWithSwitch.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/18/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit


class TableViewCellWithSwitch: UITableViewCell {
    
    @IBOutlet weak var rowSwitch: UISwitch!

    
    @IBAction func toggleNightMode(sender: AnyObject) {
        // Store the default tip selection in cache
        defaults.setObject(rowSwitch.on, forKey: UserDefaultsKeys.LowLightActivated)
        defaults.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName(NotifCenterConstants.ToggleNightMode, object: self)
    }
    
    func setSwitch() {
        let lowLightMode = defaults.objectForKey(UserDefaultsKeys.LowLightActivated)
        if lowLightMode != nil {
            rowSwitch.on = lowLightMode as! Bool
        }
    }
}