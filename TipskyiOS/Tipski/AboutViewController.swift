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
        tableView.reloadData()
    }

    
    @IBOutlet weak var fullUnlockCell: UITableViewCell!
    @IBOutlet weak var restoreCell: UITableViewCell!
    @IBOutlet weak var debugPurchasesCell: UITableViewCell!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 && UserDefaults.standard.bool(forKey: FullUnlock) {
            return super.tableView(tableView, numberOfRowsInSection: section) - 1
        }
        
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recalculate indexPath based on hidden cells
        let newIndexPath = offsetIndexPath(indexPath: indexPath)
        return super.tableView(tableView, cellForRowAt: newIndexPath)
    }
 
    func offsetIndexPath(indexPath: IndexPath) -> IndexPath {
        
        if UserDefaults.standard.bool(forKey: FullUnlock) {
        
            if indexPath.section == 0 && indexPath.row == 0 {
                return IndexPath(row: 1, section: 0)
            }
            if indexPath.section == 0 && indexPath.row == 1 {
                return IndexPath(row: 2, section: 0)
            }
//            if indexPath.section == 0 && indexPath.row == 2 {
//                
//            }
        }
        
        return IndexPath(row: indexPath.row, section: indexPath.section)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        let cell = self.tableView.cellForRow(at: indexPath)
//        if cell == fullUnlockCell &&
//            UserDefaults.standard.bool(forKey: FullUnlock) {
//                return 0
//        }
//        else if cell == debugPurchasesCell {
//            #if !DEBUG
//                // This Cell should always be visible in development Mode and always hidden in production
//                return 0
//            #endif
//        }
//        return super.tableView(tableView, heightForRowAt: indexPath)
//    }
    /*
     - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
     {
     UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
     
     if(cell == self.cellYouWantToHide)
     return 0; //set the hidden cell's height to 0
     
     return [super tableView:tableView heightForRowAtIndexPath:indexPath];
     }
 */
    
}
