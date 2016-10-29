//
//  AboutViewController.swift
//  Tipski
//
//  Created by Paul Wood on 10/19/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class AboutViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.fullUnlockChanged), name: FullUnlockChangedNotification, object: nil)

        PurchaseManager.shared.requestProduct()
        
        print(UserDefaults.standard.bool(forKey: FullUnlock))
        if UserDefaults.standard.bool(forKey: FullUnlock) {
            fullUnlockActiveLabel.isHidden = false
            debugFullUnlockSwitch.isOn = true
            buyButton.isHidden = true
        }
        else {
            fullUnlockActiveLabel.isHidden = true
            debugFullUnlockSwitch.isOn = false
            if PurchaseManager.shared.canMakePurchases(),
                let product = PurchaseManager.shared.fullUnlockProduct {
                buyButton.isHidden = false
                let price = product.localizedPrice
                let buy = NSLocalizedString("Buy: %@", comment: "Buy Button Title Format")
                let title = String(format: buy, price)
                buyButton.setTitle(title, for: .normal)
            }
        }
    }
    
    func fullUnlockChanged(note : Notification){
        print(note.object)
    }
    
    @IBOutlet weak var fullUnlockActiveLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBAction func buyPressed(_ sender: AnyObject) {
        PurchaseManager.shared.purchaseFullUpgrade()
    }
    
    @IBAction func restorePressed(_ sender: AnyObject) {
        PurchaseManager.shared.restorePastTransactions()
    }
    @IBOutlet weak var debugCell: UITableViewCell!
    @IBOutlet weak var debugFullUnlockSwitch: UISwitch!
    @IBAction func debugFullUnlockSwitchToggled(_ sender: UISwitch) {
        #if DEBUG
            if sender.isOn{
                UserDefaults.standard.set(true, forKey: FullUnlock)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: FullUnlockChangedNotification, object: nil, userInfo: nil)
            }
            else {
                UserDefaults.standard.set(false, forKey: FullUnlock)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: FullUnlockChangedNotification, object: nil, userInfo: nil)
            }
        #else
            //DO NOTHING IN PRODUCTION!
        #endif
    }

    
    
    
}
