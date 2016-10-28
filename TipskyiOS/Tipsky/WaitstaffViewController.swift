//
//  WaitstaffViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class WaitstaffViewController : TipViewController {
    
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
    
    override var preferredStatusBarStyle : UIStatusBarStyle{
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func keyboardDonePressed(_ sender: AnyObject) {
        amountTextField.resignFirstResponder()
    }
    
    // "😲😭😕😶🙂😀😍"
    @IBAction func satisfactionSliderValueChanged(sender: AnyObject) {
        
        updateViews()
    }
    
    override func updateViews(){
        
        displayTipLabels()
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
    
    func displayTipLabels (){
        stackView.arrangedSubviews[3].isHidden = false;
        stackView.arrangedSubviews[4].isHidden = false;
    }
    
    func hideTipLabels(){
        stackView.arrangedSubviews[3].isHidden = true;
        stackView.arrangedSubviews[4].isHidden = true;
    }
    
    override func displayError(){
        satisfactionLabel.text = "🤔"
        tipLabel.text = "...?"
        totalLabel.text = "...?"
        //hideTipLabels()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }

}
