//
//  SettingsViewController.swift
//  tip_calc
//
//  Created by Carlos Girod on 3/20/15.
//  Copyright (c) 2015 Carlos Girod. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tip3Field: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var betweenField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultsExist = defaults.objectForKey("defaultsExist") as! String?
        
        if defaultsExist == nil {
            defaults.setObject("yes", forKey: "defaultsExist")
            
            tipControl.setTitle("15%", forSegmentAtIndex: 0)
            tipControl.setTitle("18%", forSegmentAtIndex: 1)
            tipControl.setTitle("20%", forSegmentAtIndex: 2)
            
            defaults.setInteger(15, forKey: "tip1")
            defaults.setInteger(18, forKey: "tip2")
            defaults.setInteger(20, forKey: "tip3")
            defaults.setInteger(0, forKey: "controlIndex")
            defaults.setInteger(1, forKey: "between")
            defaults.synchronize()
            
        } else {
            var tip1 = defaults.integerForKey("tip1")
            var tip2 = defaults.integerForKey("tip2")
            var tip3 = defaults.integerForKey("tip3")
            
            tip1Field.text = "\(tip1)"
            tip2Field.text = "\(tip2)"
            tip3Field.text = "\(tip3)"
            
            tipControl.setTitle("\(tip1)%", forSegmentAtIndex: 0)
            tipControl.setTitle("\(tip2)%", forSegmentAtIndex: 1)
            tipControl.setTitle("\(tip3)%", forSegmentAtIndex: 2)
            tipControl.selectedSegmentIndex = defaults.integerForKey("controlIndex")
            
            var nPeople = defaults.integerForKey("between")
            betweenField.text = "\(nPeople)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onEditingChangedTip1(sender: AnyObject) {
        var tip = tip1Field.text!.toInt()
        if tip != nil || tip > 0 {
            tipControl.setTitle("\(tip!)%", forSegmentAtIndex: 0)
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(tip!, forKey: "tip1")
            defaults.synchronize()
        }
    }
    
    @IBAction func onEditingChangedTip2(sender: AnyObject) {
        var tip = tip2Field.text!.toInt()
        if tip != nil || tip > 0 {
            tipControl.setTitle("\(tip!)%", forSegmentAtIndex: 1)
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(tip!, forKey: "tip2")
            defaults.synchronize()
        }
    }
    
    @IBAction func onEditingChangedTip3(sender: AnyObject) {
        var tip = tip3Field.text!.toInt()
        if tip != nil || tip > 0 {
            tipControl.setTitle("\(tip!)%", forSegmentAtIndex: 2)
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(tip!, forKey: "tip3")
            defaults.synchronize()
        }
    }

    @IBAction func onEditingDone1(sender: AnyObject) {
        var tip = tip1Field.text!.toInt()
        if tip < 1 {
            tip1Field.text = ""
        }
    }
    
    @IBAction func onEditingDone2(sender: AnyObject) {
        var tip = tip2Field.text!.toInt()
        if tip < 1 {
            tip2Field.text = ""
        }
    }
    
    @IBAction func onEditingDone3(sender: AnyObject) {
        var tip = tip3Field.text!.toInt()
        if tip < 1 {
            tip3Field.text = ""
        }
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "controlIndex")
        defaults.synchronize()
    }
    
    @IBAction func onEditingChangedBetween(sender: AnyObject) {
        var between = betweenField.text!.toInt()
        if between != nil || between > 0 {
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(between!, forKey: "between")
            defaults.synchronize()
        }
    }
    
    @IBAction func onEditingDoneBetween(sender: AnyObject) {
        var tip = betweenField.text!.toInt()
        if tip < 1 {
            tip1Field.text = ""
        }
    }
    
    @IBAction func onTapReset(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(15, forKey: "tip1")
        defaults.setInteger(18, forKey: "tip2")
        defaults.setInteger(20, forKey: "tip3")
        defaults.setInteger(0, forKey: "controlIndex")
        defaults.setInteger(1, forKey: "between")
        defaults.synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
