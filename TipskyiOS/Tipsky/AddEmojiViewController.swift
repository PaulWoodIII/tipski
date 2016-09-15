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
    func didAddEmojiWith(dictionary : [String:Any?])
}

class AddEmojiViewController : UIViewController {
    
    weak var delegate : AddEmojiDelegate?
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var tipTextField: UITextField!
    
    var newItem = [String:Any?]()
    
    @IBAction func emojiTextDidChange(_ sender: AnyObject) {
        
        if let newText = emojiTextField.text {
            newItem["emoji"] = newText
        }
    }
    
    @IBAction func tipAmountDidChange(_ sender: AnyObject) {
        if let newTip = tipTextField.text,
            let tipDouble = Double(newTip){
            newItem["tip"] = tipDouble
        }
        else {
            newItem["tip"] = Double(0)
        }
    }

    @IBAction func addButtonPressed(_ sender: AnyObject) {
        delegate?.didAddEmojiWith(dictionary: newItem)
    }
    
}
