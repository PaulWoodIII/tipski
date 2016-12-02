//
//  BartenderViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class BartenderViewController : TipViewController {
    
    @IBOutlet weak var drinkTextField: UITextField!
    @IBOutlet weak var tipAmountKeyLabel: UILabel!
    @IBOutlet weak var tipAmountValueLabel: UILabel!
    
    override var emojiList : Array<TipEmoji>! {
        get {
            return Datastore.shared.barTipEmojis
        }
        set {
            Datastore.shared.barTipEmojis = newValue
            Datastore.shared.persist()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createInput(textField: drinkTextField)
        drinkTextField.inputAccessoryView = self.doneToolbar
    }
    
    override func updateViews(){
        let sat = Double(satisfactionSlider.value)
        
        let increment = 1.0 / Double(Datastore.shared.barTipEmojis.count)
        var minBounds = 0.0
        var foundSat : TipEmoji = Datastore.shared.barTipEmojis[0]
        
        for i in 0..<Datastore.shared.barTipEmojis.count {
            if(minBounds > sat){
                break
            }
            minBounds = minBounds + increment;
            foundSat = Datastore.shared.barTipEmojis[i]
        }
        
        let satisfactionText = foundSat.emoji
        let tip : Double! = foundSat.tipAmount
        
        
        satisfactionLabel.text = satisfactionText
        if let amount = Double(drinkTextField.text!){
            tipAmountValueLabel.text = "\(prettyPrintMoney(amount * tip))"
        }
        else {
            displayError()
        }
    }
    
    override func displayError(){
        super.displayError()
        tipAmountValueLabel.text = "...?"
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }
    
    @IBAction override func keyboardDonePressed(_ sender: AnyObject) {
        drinkTextField.resignFirstResponder()
    }
    
}
