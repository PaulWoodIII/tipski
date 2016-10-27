//
//  ViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/12/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
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
    
    func displayError(){

    }

    @IBAction func settingsPressed() {
        self.performSegue(withIdentifier: Segues.settings.rawValue, sender: nil)
    }
    
}
