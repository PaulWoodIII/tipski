//
//  MaidViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

class MaidViewController : TipViewController {
    
    @IBOutlet weak var nightsTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
        
    @IBOutlet weak var stackView: UIStackView!
    
    override var emojiList : Array<TipEmoji>! {
        get {
            return Datastore.shared.maidTipEmojis
        }
        set {
            Datastore.shared.maidTipEmojis = newValue
            Datastore.shared.persist()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createInput(textField: nightsTextField)
        nightsTextField.inputAccessoryView = self.doneToolbar
        updateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func keyboardDonePressed(_ sender: AnyObject) {
        super.keyboardDonePressed(sender)
        nightsTextField.resignFirstResponder()
    }
    
    override func updateViews(){
        
        let sat = Double(satisfactionSlider.value)
        
        let increment = 1.0 / Double(Datastore.shared.maidTipEmojis.count)
        var minBounds = 0.0
        var foundSat : TipEmoji = Datastore.shared.maidTipEmojis[0]
        
        for i in 0..<Datastore.shared.maidTipEmojis.count {
            if(minBounds > sat){
                break
            }
            minBounds = minBounds + increment;
            foundSat = Datastore.shared.maidTipEmojis[i]
        }
        
        let satisfactionText = foundSat.emoji
        let tip : Double! = foundSat.tipAmount
        
        
        satisfactionLabel.text = satisfactionText
        if let nights = Double(nightsTextField.text!){
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
    
}
