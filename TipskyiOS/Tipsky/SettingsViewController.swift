//
//  SettingsViewController.swift
//  Tipsky
//
//  Created by Paul Wood on 9/14/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import UIKit

protocol EmojiListDelegate : class {
    func didFinish(withList tipList: Array<TipEmoji>)
}

class SettingsViewController: UITableViewController, UIPopoverControllerDelegate, AddEmojiDelegate {

    var customerSatLevel : Array<TipEmoji>!
    weak var delegate : EmojiListDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setEditing(true, animated: false)
    }
    
    @IBAction func donePressed(_ sender: AnyObject) {
        if let delegate = delegate {
            delegate.didFinish(withList: customerSatLevel)
        }
        goBack()
    }
    
    @IBAction func sortPressed(_ sender: AnyObject) {
        sortList()
    }
    
    func goBack(){
        //Something should happen here like updating the array
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func sortList(){
        customerSatLevel =
            customerSatLevel.sorted(by: {
                return $0.tipAmount < $1.tipAmount
            })
        self.tableView.reloadData()
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
        cell.textLabel!.text = object.emoji
        cell.detailTextLabel!.text = "\(object.tipAmount)"
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
    
    func didAddEmoji(tipEmoji: TipEmoji) {
        //Add To Items
        customerSatLevel.insert(tipEmoji, at: 0)
        //Create Index
        let idx = IndexPath(row: 0, section: 0)
        //Add Index to Table View
        tableView.insertRows(at: [idx as IndexPath], with: .middle)
        
        navigationController!.popViewController(animated: true)
    }
    
}

