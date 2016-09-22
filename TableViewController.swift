//
//  TableViewController.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/6/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    struct SettingsTableConstants {
        struct DefaultTip {
            static let Section = 0
            static let SectionLabel = "Default Tip"
            static let NumRows = 3
            static let Id = "cell"
        }
        struct LowLight {
            static let Section = 1
            static let SectionLabel = "Appearance"
            static let NumRows = 1
            static let Id = "theme"
        }
    }

    var checkedCell: Int?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Mark the default tip with a check mark
        let defaultTipIdx = defaults.objectForKey(UserDefaultsKeys.DefaultTip) as! Int
        let index = NSIndexPath(forRow: defaultTipIdx, inSection: SettingsTableConstants.DefaultTip.Section)
        if let cell = tableView.cellForRowAtIndexPath(index) {
            cell.accessoryType = .Checkmark
            checkedCell = defaultTipIdx
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case SettingsTableConstants.DefaultTip.Section:
            return SettingsTableConstants.DefaultTip.SectionLabel
        case SettingsTableConstants.LowLight.Section:
            return SettingsTableConstants.LowLight.SectionLabel
        default:
            return ""
        }
    }
    
    // Return the number of sections.
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 2
    }
    
    // Return the number of rows
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case SettingsTableConstants.DefaultTip.Section:
            return SettingsTableConstants.DefaultTip.NumRows
        case SettingsTableConstants.LowLight.Section:
            return SettingsTableConstants.LowLight.NumRows
        default:
            return 0
        }
    }
    
    // Handle when user taps a new default percentage
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == SettingsTableConstants.DefaultTip.Section {
            // Store the default tip selection in cache
            defaults.setObject(indexPath.row, forKey: UserDefaultsKeys.DefaultTip)
            defaults.synchronize()

            // Update UI to uncheck last cell and check new cell
            let index = NSIndexPath(forRow: checkedCell!, inSection: SettingsTableConstants.DefaultTip.Section)
            if let uncheckCell = tableView.cellForRowAtIndexPath(index) {
                uncheckCell.accessoryType = .None
            }
            checkedCell = indexPath.row
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.accessoryType = .Checkmark
            }
        }
    }
    
    // Render desired table rows
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch (indexPath.section) {
            case SettingsTableConstants.LowLight.Section:
                let cell = tableView.dequeueReusableCellWithIdentifier(
                    SettingsTableConstants.LowLight.Id,
                    forIndexPath: indexPath) as! TableViewCellWithSwitch
                let lowLightActivated = defaults.objectForKey(UserDefaultsKeys.LowLightActivated) as! Bool
                cell.rowSwitch.on = lowLightActivated
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(
                    SettingsTableConstants.DefaultTip.Id,
                    forIndexPath: indexPath)
                let label = "\(Int(tipValues[row] * 100))%"
                cell.textLabel!.text = label
                return cell
        }
    }
}
