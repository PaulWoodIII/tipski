//
//  AddEmojiViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/15/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

protocol AddEmojiDelegate : class {
    func didAddEmoji(tipEmoji: TipEmoji)
}

class AddEmojiViewController : UIViewController {
    
    weak var delegate : AddEmojiDelegate?
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var tipTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    var newItem = TipEmoji(emoji: "",tipAmount: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createWellFromView(view: containerView)
        Appearance.createInput(textField: emojiTextField)
        Appearance.createInput(textField: tipTextField)
        Appearance.createSubmitButton(button: addButton)
    }
    
    @IBAction func emojiTextDidChange(_ sender: AnyObject) {
        
        if let newText = emojiTextField.text {
            newItem.emoji = newText
        }
    }
    
    @IBAction func tipAmountDidChange(_ sender: AnyObject) {
        if let newTip = tipTextField.text,
            let tipDouble = Double(newTip){
            newItem.tipAmount = tipDouble
        }
        else {
            newItem.tipAmount = Double(0)
        }
    }

    @IBAction func addButtonPressed(_ sender: AnyObject) {
        delegate?.didAddEmoji(tipEmoji: newItem)
    }
    
}
