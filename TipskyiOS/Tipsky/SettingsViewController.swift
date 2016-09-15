//
//  SettingsViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/14/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPopoverControllerDelegate, AddEmojiDelegate {

    var customerSatLevel : [[String:Any?]]!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(customerSatLevel)
        tableView.setEditing(true, animated: false)
    }
    
    @IBAction func donePressed(_ sender: AnyObject) {
        goBack()
    }
    
    func goBack(){
        //Something should happen here like updating the array
        if let home = self.presentingViewController as? ViewController {
            home.customerSatLevel = customerSatLevel;
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerSatLevel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        let object = customerSatLevel[indexPath.row]
        cell.textLabel!.text = object["emoji"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            customerSatLevel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Whao
        if sourceIndexPath.row == destinationIndexPath.row {
            return
        }//else
        
        swap(&customerSatLevel[sourceIndexPath.row], &customerSatLevel[destinationIndexPath.row])
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddEmojiViewController {
            addVC.delegate = self
        }
    }
    
    func didAddEmojiWith(dictionary: [String : Any?]) {
        print(dictionary)
        //Add To Items
        customerSatLevel.insert(dictionary, at: 0)
        //Create Index
        let idx = IndexPath(row: 0, section: 0)
        //Add Index to Table View
        tableView.insertRows(at: [idx as IndexPath], with: .middle)
        
        navigationController?.popViewController(animated: true)
    }
    
}
