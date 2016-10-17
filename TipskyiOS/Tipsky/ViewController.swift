//
//  ViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/12/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var satisfactionLabel: UILabel!
    
    @IBOutlet weak var satisfactionSlider: UISlider!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var containerView: UIView!
    
    var customerSatLevel = [
        ["emoji":"😷","tip":0.0],
        ["emoji":"😭","tip":0.01],
        ["emoji":"😕","tip":0.08],
        ["emoji":"😶","tip":0.12],
        ["emoji":"🙂","tip":0.15],
        ["emoji":"😀","tip":0.18],
        ["emoji":"😍","tip":0.5]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createWellFromView(view: containerView)
        Appearance.createInput(textField: amountTextField)
        
        updateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // "😲😭😕😶🙂😀😍"
    @IBAction func satisfactionSliderValueChanged(sender: AnyObject) {
        
        updateViews()
    }
    
    func updateViews(){
        
        displayTipLabels()
        let sat = Double(satisfactionSlider.value)

        let increment = 1.0 / Double(customerSatLevel.count)
        var minBounds = 0.0
        var foundSat = customerSatLevel[0]
        
        for i in 0..<customerSatLevel.count {
            if(minBounds > sat){
                break
            }
            minBounds = minBounds + increment;
            foundSat = customerSatLevel[i]
        }
        
        let satisfactionText = foundSat["emoji"] as! String!
        let tip : Double! = foundSat["tip"] as! Double!
        
        
        satisfactionLabel.text = satisfactionText
        if let amount = Double(amountTextField.text!){
            tipLabel.text = "\(prettyPrintMoney(amount * tip))"
            totalLabel.text = "\(prettyPrintMoney((amount * tip) + amount ))"
        }
        else {
            displayError()
        }
    }
    
    let numberFormatter : NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()
    
    func prettyPrintMoney(_ value : Double) -> String {
        let num = NSNumber(value: value)
        return numberFormatter.string(from: num)!
    }
    
    func displayTipLabels (){
        stackView.arrangedSubviews[3].isHidden = false;
        stackView.arrangedSubviews[4].isHidden = false;
    }
    
    func hideTipLabels(){
        stackView.arrangedSubviews[3].isHidden = true;
        stackView.arrangedSubviews[4].isHidden = true;
    }
    
    func displayError(){
        satisfactionLabel.text = "🤔"
        tipLabel.text = ""
        totalLabel.text = ""
        //hideTipLabels()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }

    @IBAction func settingsPressed() {
        self.performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let settings = nav.topViewController as? SettingsViewController
            {
            settings.customerSatLevel = customerSatLevel
        }
    }
    
}

