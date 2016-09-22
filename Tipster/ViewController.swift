//
//  ViewController.swift
//  Tipster
//
//  Created by Bryce Aebi on 9/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    let textFieldLimit = 8
    
    // Current string for amount textfield
    var currentString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.activeAgain), name: UIApplicationWillEnterForegroundNotification, object:nil)
        defaults.setObject(false, forKey: UserDefaultsKeys.LowLightActivated)
        defaults.synchronize()
        
    }
    
    // If app is brought to foreground, show the last saved bill amount
    // unless the app has been backgrounded for more than 10 minutes
    func activeAgain() {
        if let savedTime = defaults.objectForKey(UserDefaultsKeys.BillSavedDateKey) {
            let interval = NSDate().timeIntervalSinceDate(savedTime as! NSDate)
            let savedAmount = defaults.objectForKey(UserDefaultsKeys.BillSavedAmountKey) as! String
            let savedAmountString = defaults.objectForKey(UserDefaultsKeys.BillSavedStringKey) as! String
            if interval <= 600 {
                textField.text = savedAmountString
                currentString = savedAmount
            } else {
                textField.text = ""
                currentString = ""
            }
        }
        calculateTip(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch any saved default tip percentage
        let defaultTipIdx = defaults.objectForKey(UserDefaultsKeys.DefaultTip) as! Int
        tipControl.selectedSegmentIndex = defaultTipIdx
        calculateTip(self)
    }

    // Format amount with correct currency symbol and limit number of digits in amount
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            // Enforce maximum character length of bill
            if (currentString.characters.count <= textFieldLimit) {
                currentString += string
                textField.text = formatCurrency(currentString)
            }
         case ".": // ignore decimal points
            return false
         default: // deletion case
            var currentStringArray = Array(currentString.characters)
            if currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                textField.text = formatCurrency(currentString)
            }
        }
        saveTextFieldValue()
        calculateTip(self)
        return false
    }
    
    // Format currency as local currency and update textfield
    func formatCurrency(string: String) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        let numberFromField = (NSString(string: string).doubleValue)/100
        return formatter.stringFromNumber(numberFromField)!
    }

    // Save every new bill amount
    func saveTextFieldValue() {
        defaults.setObject(textField.text!, forKey: UserDefaultsKeys.BillSavedStringKey)
        defaults.setObject(currentString, forKey: UserDefaultsKeys.BillSavedAmountKey)
        defaults.setObject(NSDate(), forKey: UserDefaultsKeys.BillSavedDateKey)
        defaults.synchronize()
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let bill = Double(currentString) ?? 0
        let billWithoutCents = floor(bill/100)*100.0
        let tip = billWithoutCents * tipValues[tipControl.selectedSegmentIndex]
        let total = tip + bill
        tipLabel.alpha = 0
        totalLabel.alpha = 0
        tipLabel.text = formatCurrency(String(tip))
        totalLabel.text = formatCurrency(String(total))
        animateTip()
    }
    
    func animateTip() {
        UIView.animateWithDuration(0.2, animations: {
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
    }
}

