//
//  ViewController.swift
//  tip_calculator
//
//  Created by etsloaner on 12/31/15.
//  Copyright © 2015 ytian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipPercentControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var isFirstTime = true
    var tipPercentList = [0.1, 0.15, 0.2]

    @IBOutlet weak var calculatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.text = "$"
        self.title = "Tips Calculator"
        
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercent = tipPercentList[tipPercentControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        
        let tip = billAmount * tipPercent
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "default_amount_value")
        defaults.synchronize()
        
        if self.calculatedView.alpha == 0 {
            UIView.animateWithDuration(0.4, animations: {
                self.calculatedView.alpha = 1
            })
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
        if billField.text == "" {
            billField.text = "$"
            UIView.animateWithDuration(0.4, animations: {
                self.calculatedView.alpha = 0
            })
        }
        
    }
    @IBAction func onEditingBegin(sender: AnyObject) {
        if billField.text == "$" {
            billField.text = ""
            self.calculatedView.alpha = 0
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let nowTime = NSDate().timeIntervalSince1970
        var thenTime: Double = 0.0
        
        if let testTime : Double? = defaults.doubleForKey("time_since_exit") {
            print("got then time")
            print(testTime)
            thenTime = testTime!
        }
        if let testArray = defaults.objectForKey("tip_percent_list") {
            tipPercentList = testArray as! [Double]
        }
        if let testIndex : Int? = defaults.integerForKey("default_tip_percentage_index"){
            tipPercentControl.selectedSegmentIndex = testIndex!
        }
  
        for(var i = 0; i < tipPercentList.endIndex; i++){
            let percent = tipPercentList[i]
            let valueName = String(format: "%.0f%%", percent * 100)
            tipPercentControl.setTitle(valueName, forSegmentAtIndex: i)
        }
        
        let elapsedTimeInMin = (nowTime - thenTime)/1000/60
        print("elapsed min time")
        print(elapsedTimeInMin)
        if elapsedTimeInMin < 10.0 {
            if let testAmount = defaults.objectForKey("default_amount_value") {
                billField.text = testAmount as? String
            }
        }
        
        billField.reloadInputViews()
        onEditingChanged([]) //update from when return from settings
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let time = NSDate().timeIntervalSince1970
        print("then time")
        print(time)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(time, forKey: "time_since_exit")
        defaults.synchronize()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

