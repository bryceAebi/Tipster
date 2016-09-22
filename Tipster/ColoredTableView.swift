//
//  ColoredTableView.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/18/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ColoredTableView: UITableView {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ColoredTableView.updateAppearance), name: appearanceChangeNotification, object: nil)
    }
    
    func updateAppearance() {
        let isLowLight = defaults.objectForKey("low_light_activated") ?? false
        if (isLowLight != nil) {
            if isLowLight as! Bool {
                self.backgroundColor = UIColor.darkGrayColor()
            } else {
                self.backgroundColor = UIColor.whiteColor()
            }
        }
    }
}
