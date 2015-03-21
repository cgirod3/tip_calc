//
//  ViewController.swift
//  tip_calc
//
//  Created by Carlos Girod on 3/18/15.
//  Copyright (c) 2015 Carlos Girod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var personStepper: UIStepper!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultsExist = defaults.objectForKey("defaultsExist") as! String?
        if defaultsExist != nil {
            var tip1 = defaults.integerForKey("tip1")
            var tip2 = defaults.integerForKey("tip2")
            var tip3 = defaults.integerForKey("tip3")
            
            tipControl.setTitle("\(tip1)%", forSegmentAtIndex: 0)
            tipControl.setTitle("\(tip2)%", forSegmentAtIndex: 1)
            tipControl.setTitle("\(tip3)%", forSegmentAtIndex: 2)
            tipControl.selectedSegmentIndex = defaults.integerForKey("controlIndex")
            
            var person = defaults.integerForKey("between")
            personStepper.value = Double(person)
            personLabel.text = "\(person)"
        }
        
        billField.text = defaults.objectForKey("bill") as! String?
        onEditingChangedBillField(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChangedBillField(sender: AnyObject) {
        var tip1: String = tipControl.titleForSegmentAtIndex(0)!
        tip1 = tip1.substringToIndex(advance(tip1.startIndex, count(tip1)-1))
        var tip2: String = tipControl.titleForSegmentAtIndex(1)!
        tip2 = tip2.substringToIndex(advance(tip2.startIndex, count(tip2)-1))
        var tip3: String = tipControl.titleForSegmentAtIndex(2)!
        tip3 = tip3.substringToIndex(advance(tip3.startIndex, count(tip3)-1))
        
        var tips = [tip1.toInt(), tip2.toInt(), tip3.toInt()]
        
        var string = NSString(string: billField.text)
        var billAmount = string.doubleValue
        
        var tip = Double(tips[tipControl.selectedSegmentIndex]!) * 0.01 * billAmount
        var total = billAmount + tip
        tip = tip/personStepper.value
        total = total/personStepper.value
        
        var tipString = String(format: "$%.2f", tip)
        var totalString = String(format: "$%.2f", total)
        
        tipLabel.text = tipString
        totalLabel.text = totalString
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipString, forKey: "tip")
        defaults.setObject(totalString, forKey: "total")
        defaults.setObject(billField.text, forKey: "bill")
    }
    
    @IBAction func onValueChangedStepper(sender: AnyObject) {
        var val = Int(personStepper.value)
        personLabel.text = "\(val)"
    }

    @IBAction func onTapMain(sender: AnyObject) {
        println("COME ONE")
        view.endEditing(true)
    }
}

