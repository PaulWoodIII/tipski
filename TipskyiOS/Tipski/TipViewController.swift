//
//  ViewController.swift
//  Tipski
//
//  Created by Paul Wood on 9/12/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    /* The Core Components of all Tip Views is the Satisfction Label and Slider. 
       These two UIComponenets should be front and center on all subclass's views
     */
    @IBOutlet weak var satisfactionLabel: UILabel!
    @IBOutlet weak var satisfactionSlider: UISlider!

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var doneToolbar: UIToolbar!
    
    var emojiList : Array<TipEmoji>! {
        get {
            fatalError("Subclasses must override emojiList variable getter and setter")
        }
        set {
            fatalError("Subclasses must override emojiList variable getter and setter")
        }
    }
    
    let numberFormatter : NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance.createWellFromView(view: containerView)
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
    
    func updateViews(){
        
    }
    
    func prettyPrintMoney(_ value : Double) -> String {
        let num = NSNumber(value: value)
        return numberFormatter.string(from: num)!
    }
    
    //Subclasses must call super
    func displayError(){
        satisfactionLabel.text = "🤔"
    }

    @IBAction func settingsPressed() {
        self.performSegue(withIdentifier: Segues.settings.rawValue, sender: nil)
    }
    
    // "😲😭😕😶🙂😀😍"
    @IBAction func satisfactionSliderValueChanged(sender: AnyObject) {
        updateViews()
    }
    
    @IBAction func keyboardDonePressed(_ sender: AnyObject) {

    }
    
    
    @IBAction func emojiTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            animateSatisfactionLabel()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.settings.rawValue {
            if let nav = segue.destination as? UINavigationController,
                let vc = nav.topViewController as? SettingsViewController {
                vc.customerSatLevel = self.emojiList
                vc.delegate = self
            }
        }
    }
    
    func animateSatisfactionLabel(){
        // http://stackoverflow.com/a/32890257/283460
        self.satisfactionLabel.transform =  CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.satisfactionLabel.transform = .identity
        }, completion: nil)
    }
}

extension TipViewController : EmojiListDelegate{
    func didFinish(withList tipList: Array<TipEmoji>) {
        self.emojiList = tipList
        updateViews()
    }
}
