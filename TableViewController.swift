//
//  TableViewController.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/6/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    let tipValues = ["15%", "20%", "25%"]
    var checkedCell: Int?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Mark the default tip with a check mark
        let defaultTipIdx = defaults.objectForKey("default_tip") as! Int
        let index = NSIndexPath(forRow: defaultTipIdx, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(index) {
            cell.accessoryType = .Checkmark
            checkedCell = defaultTipIdx
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Default Tip"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return 3
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        // Store the default tip selection in cache
        defaults.setObject(indexPath.row, forKey: "default_tip")
        defaults.synchronize()

        // Update UI to uncheck last cell and check new cell
        let index = NSIndexPath(forRow: checkedCell!, inSection: 0)
        if let uncheckCell = tableView.cellForRowAtIndexPath(index) {
            uncheckCell.accessoryType = .None
        }
        checkedCell = indexPath.row
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .Checkmark
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "cell",
            forIndexPath: indexPath)
        let label = tipValues[row]
        cell.textLabel!.text = label
        return cell
    }
    
}
