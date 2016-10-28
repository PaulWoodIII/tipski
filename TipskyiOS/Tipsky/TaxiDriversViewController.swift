//
//  TaxiDriversViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class TaxiDriversViewController : TipViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createInput(textField: amountTextField)
        amountTextField.inputAccessoryView = self.doneToolbar
        updateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func keyboardDonePressed(_ sender: AnyObject) {
        amountTextField.resignFirstResponder()
    }
    
    override func updateViews(){
        
        let sat = Double(satisfactionSlider.value)
        
        let increment = 1.0 / Double(Datastore.shared.tipEmojis.count)
        var minBounds = 0.0
        var foundSat : TipEmoji = Datastore.shared.tipEmojis[0]
        
        for i in 0..<Datastore.shared.tipEmojis.count {
            if(minBounds > sat){
                break
            }
            minBounds = minBounds + increment;
            foundSat = Datastore.shared.tipEmojis[i]
        }
        
        let satisfactionText = foundSat.emoji
        let tip : Double! = foundSat.tipAmount
        
        
        satisfactionLabel.text = satisfactionText
        if let amount = Double(amountTextField.text!){
            tipLabel.text = "\(prettyPrintMoney(amount * tip))"
            totalLabel.text = "\(prettyPrintMoney((amount * tip) + amount ))"
        }
        else {
            displayError()
        }
    }
    
    override func displayError(){
        super.displayError()
        tipLabel.text = "...?"
        totalLabel.text = "...?"
        //hideTipLabels()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }
    
}
