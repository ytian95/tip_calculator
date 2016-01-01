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
        print(billAmount)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
        if billField.text == "" {
            billField.text = "$"
        }
        
    }
    @IBAction func onEditingBegin(sender: AnyObject) {
        if billField.text == "$" {
            billField.text = ""
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let testArray = defaults.objectForKey("tip_percent_list") {
            print(testArray)
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
        
        onEditingChanged([]) //update from when return from settings
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

