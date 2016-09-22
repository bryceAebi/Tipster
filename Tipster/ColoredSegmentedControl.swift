//
//  ColoredSegmentedControl.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/18/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ColoredSegmentedControl: UISegmentedControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ColoredSegmentedControl.updateAppearance), name: NotifCenterConstants.ToggleNightMode, object: nil)
    }
    
    func updateAppearance() {
        let isLowLight = defaults.objectForKey(UserDefaultsKeys.LowLightActivated) as! Bool
        if isLowLight {
            self.tintColor = UIColor.lightGrayColor()
        } else {
            self.tintColor = AppColors.DarkGreen
        }
    }
}
