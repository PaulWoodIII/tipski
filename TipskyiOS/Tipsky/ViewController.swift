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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let sat = satisfactionSlider.value
        var satisfactionText = "😶"
        var tip = 0.0
        
        if sat < 0.15 {
            satisfactionText = "😷"
            tip = 0.0
        }
        else if sat < 0.30 {
            satisfactionText = "😭"
            tip = 0.01
        }
        else if sat < 0.45 {
            satisfactionText = "😕"
            tip = 0.08
        }
        else if sat < 0.60 {
            satisfactionText = "😶"
            tip = 0.12
        }
        else if sat < 0.75 {
            satisfactionText = "🙂"
            tip = 0.15
        }
        else if sat < 0.90 {
            satisfactionText = "😀"
            tip = 0.18
        }
        else {
            satisfactionText = "😍"
            tip = 0.5
        }
        
        satisfactionLabel.text = satisfactionText
        if let amount = Double(amountTextField.text!){
            tipLabel.text = "Tip: \(prettyPrintMoney(amount * tip))"
            totalLabel.text = "Total: \(prettyPrintMoney((amount * tip) + amount ))"
        }
        else {
            displayError()
        }
    }
    
    let numberFormatter : NumberFormatter = {
        let nForm = NumberFormatter()
        nForm.numberStyle = .currency
        return nForm
    }()
    
    func prettyPrintMoney(_ value : Double) -> String {
        let num = NSNumber(value: value)
        return numberFormatter.string(from: num)!
    }
    
    func displayError(){
        satisfactionLabel.text = "🤔"
        tipLabel.text = ""
        totalLabel.text = ""
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }

}

