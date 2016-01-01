//
//  SettingsViewController.swift
//  tip_calculator
//
//  Created by etsloaner on 12/31/15.
//  Copyright © 2015 ytian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTipPercentControl: UISegmentedControl!
    
    @IBOutlet weak var tipPercent1: UITextField!
    @IBOutlet weak var tipPercent2: UITextField!
    @IBOutlet weak var tipPercent3: UITextField!
    
    var tipPercentages = [0.1, 0.15, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Settings"
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
    
    @IBAction func onEditingChanged1(sender: AnyObject) {
        let tipPercent = NSString(string: tipPercent1.text!).doubleValue
        changePercentValue(tipPercent, position: 0)
    }

    @IBAction func onEditingChanged2(sender: AnyObject) {
        let tipPercent = NSString(string: tipPercent2.text!).doubleValue
        changePercentValue(tipPercent, position: 1)

    }
    
    @IBAction func onEditingChanged3(sender: AnyObject) {
        let tipPercent = NSString(string: tipPercent3.text!).doubleValue
        changePercentValue(tipPercent, position: 2)

    }
    
    func changePercentValue(value: Double, position: Int){
        let valueName = String(format: "%.0f%%", value * 100)
        
        settingsTipPercentControl.setTitle(valueName, forSegmentAtIndex: position)
        tipPercentages[position] = value
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tipPercentages, forKey: "tip_percent_list")
        defaults.synchronize()
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(settingsTipPercentControl.selectedSegmentIndex, forKey: "default_tip_percentage_index")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let testArray = defaults.objectForKey("tip_percent_list") {
            tipPercentages = testArray as! [Double]
            
        }
        if let testIndex : Int? = defaults.integerForKey("default_tip_percentage_index"){
            settingsTipPercentControl.selectedSegmentIndex = testIndex!
        }
        
        for(var i = 0; i < tipPercentages.endIndex; i++){
            let percent = tipPercentages[i]
            let valueName = String(format: "%.0f%%", percent * 100)
            settingsTipPercentControl.setTitle(valueName, forSegmentAtIndex: i)
        }
        
        tipPercent1.text = String(format: "%.2f", tipPercentages[0])
        tipPercent2.text = String(format: "%.2f", tipPercentages[1])
        tipPercent3.text = String(format: "%.2f", tipPercentages[2])
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
