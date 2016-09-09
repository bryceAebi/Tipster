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
    
    let textFieldLimit = 9
    let defaults = NSUserDefaults.standardUserDefaults()
    let billSavedDateKey = "bill_saved_date_key"
    let billSavedAmountKey = "bill_saved_amount_key"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        textField.delegate = self

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "activeAgain", name: UIApplicationWillEnterForegroundNotification, object:nil)
    }
    
    // If app is brought to foreground, show the last saved bill amount
    // unless the app has been backgrounded for more than 10 minutes
    func activeAgain() {
        if let savedTime = defaults.objectForKey(billSavedDateKey) {
            let interval = NSDate().timeIntervalSinceDate(savedTime as! NSDate)
            let savedAmount = defaults.objectForKey(billSavedAmountKey) as! String
            if interval <= 600 {
                textField.text = savedAmount
            } else {
                textField.text = ""
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        // Fetch any saved default tip percentage
        let defaultTipIdx = defaults.objectForKey("default_tip") as! Int
        tipControl.selectedSegmentIndex = defaultTipIdx
    }

    // Enforce maximum character length of bill
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= textFieldLimit
    }

    // Save every new bill amount
    @IBAction func saveValue(sender: AnyObject) {
        defaults.setObject(textField.text!, forKey: billSavedAmountKey)
        defaults.setObject(NSDate(), forKey: billSavedDateKey)
        defaults.synchronize()
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.2, 0.25]
        let bill = Double(textField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
 
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    // I want the keypad to always be open so
    // the following function is commented out
    /*
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    */
}

