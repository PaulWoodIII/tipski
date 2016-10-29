//
//  AddEmojiViewController.swift
//  Tipski
//
//  Created by Paul Wood on 9/15/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

protocol AddEmojiDelegate : class {
    func didAddEmoji(tipEmoji: TipEmoji)
}

class AddEmojiViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    weak var delegate : AddEmojiDelegate?
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var tipTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredEmojis : [Emoji] = Emoji.allEmojis
    
    var newItem = TipEmoji(emoji: "",tipAmount: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
        Appearance.createWellFromView(view: containerView)
        Appearance.createInput(textField: emojiTextField)
        Appearance.createInput(textField: tipTextField)
        Appearance.createSubmitButton(button: addButton)
    }
    
    @IBAction func emojiTextDidChange(_ textField: UITextField) {
        if let text = textField.text ,
            text != "",
            !collectionView.isHidden {
            filteredEmojis = Emoji.allEmojis.filter() {
                return ($0.fts as NSString).localizedCaseInsensitiveContains(text)
            }
            print(filteredEmojis)
        }
        collectionView.reloadData()
        
        if let newText = emojiTextField.text,
            newText.isEmoji {
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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredEmojis.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath)
        print(cell.subviews)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = filteredEmojis[indexPath.row].char
        return cell
    }

    
    //
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        if textField == emojiTextField {
            //display the UICollectionView
            collectionView.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason){
        if textField == emojiTextField {
            collectionView.isHidden = true
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emojiTextField {
            emojiTextDidChange(textField)
        }
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let char = filteredEmojis[indexPath.row].char
        emojiTextField.text = char
        newItem.emoji = char
        emojiTextField.resignFirstResponder()
    }
    
}

