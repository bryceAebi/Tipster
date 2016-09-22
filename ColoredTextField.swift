//
//  ColoredTextField.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/19/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ColoredTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ColoredTextField.updateAppearance), name: NotifCenterConstants.ToggleNightMode, object: nil)
    }
    
    func updateAppearance() {
        let isLowLight = defaults.objectForKey(UserDefaultsKeys.LowLightActivated) as! Bool
        if isLowLight {
            self.backgroundColor = UIColor.lightGrayColor()
        } else {
            self.backgroundColor = AppColors.LightGreen
        }
    }
}
