//
//  ColoredLabel.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/18/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ColoredLabel: UILabel {
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ColoredLabel.updateAppearance), name: NotifCenterConstants.ToggleNightMode, object: nil)
    }
    
    func updateAppearance() {
        let isLowLight = defaults.objectForKey(UserDefaultsKeys.LowLightActivated) as! Bool
        if isLowLight {
            self.textColor = UIColor.lightGrayColor()
        } else {
            self.textColor = UIColor.blackColor()
        }
    }
}
