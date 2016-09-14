//
//  SettingsViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/14/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    @IBAction func donePressed(_ sender: AnyObject) {
        goBack()
    }
    
    func goBack(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
