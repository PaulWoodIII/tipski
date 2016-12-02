//
//  BellHopViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class BellHopViewController : TipViewController {
    
    @IBOutlet weak var bagsTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override var emojiList : Array<TipEmoji>! {
        get {
            return Datastore.shared.bellHopTipEmojis
        }
        set {
            Datastore.shared.bellHopTipEmojis = newValue
            Datastore.shared.persist()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createInput(textField: bagsTextField)
        bagsTextField.inputAccessoryView = self.doneToolbar
        updateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func keyboardDonePressed(_ sender: AnyObject) {
        super.keyboardDonePressed(sender)
        bagsTextField.resignFirstResponder()
    }
    
    override func updateViews(){
        
        let sat = Double(satisfactionSlider.value)
        
        let increment = 1.0 / Double(Datastore.shared.bellHopTipEmojis.count)
        var minBounds = 0.0
        var foundSat : TipEmoji = Datastore.shared.bellHopTipEmojis[0]
        
        for i in 0..<Datastore.shared.bellHopTipEmojis.count {
            if(minBounds > sat){
                break
            }
            minBounds = minBounds + increment;
            foundSat = Datastore.shared.bellHopTipEmojis[i]
        }
        
        let satisfactionText = foundSat.emoji
        let tip : Double! = foundSat.tipAmount
        
        
        satisfactionLabel.text = satisfactionText
        if let nights = Double(bagsTextField.text!){
            tipLabel.text = "\(prettyPrintMoney(nights * tip))"
        }
        else {
            displayError()
        }
    }
    
    override func displayError(){
        super.displayError()
        tipLabel.text = "...?"
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.settings.rawValue {
            if let vc = segue.destination as? SettingsViewController {
                vc.customerSatLevel = Datastore.shared.bellHopTipEmojis
            }
        }
    }
    
}
