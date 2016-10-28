//
//  ViewController.swift
//  Tipsky
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
}

