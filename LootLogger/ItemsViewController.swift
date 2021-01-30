//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Saber on 25/01/2021.
//

import UIKit
import Foundation

class ItemsViewController : UITableViewController{
    var itemStore: ItemStore!
    override func viewDidLoad() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    @IBAction func addNewItem(_ sender: UIButton){
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    @IBAction func toggleEditingMode(_ sender: UIButton){
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLAbel.text = "$\(item.valueInDollar)"
        return cell
       
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}