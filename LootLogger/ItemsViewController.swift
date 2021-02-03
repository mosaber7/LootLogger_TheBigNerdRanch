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
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        let newItem = itemStore.createItem()
        if newItem.isCheeperTHanFifty{
            if let index = itemStore.allItems[0].firstIndex(of: newItem){
                let indexPath = IndexPath(row: index, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        
        }else if !newItem.isCheeperTHanFifty{
        if let index = itemStore.allItems[1].firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 1)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    
}
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
   
    
    // define how many sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //required : define how many row in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems[section].count
    }
    //required: construct the cell of each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //recylclar view, instead of building 1000 cells, make 10 and reuse them
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.section][indexPath.row];
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollar)"
        if item.isCheeperTHanFifty{
            cell.valueLabel.textColor = .green
        }else{
            cell.valueLabel.textColor = .red
        }
        return cell
       
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.section][indexPath.row]
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        itemStore.moveItem(from: sourceIndexPath.row, toIndex: destinationIndexPath.row, fromSection: sourceIndexPath.section, toSection: destinationIndexPath.section)
    }
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section{return sourceIndexPath}
        else{return proposedDestinationIndexPath}
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row, let section = tableView.indexPathForSelectedRow?.section{
                let item = itemStore.allItems[section][row]
                let detailViewController = segue.destination as! DetailViewControllers
                detailViewController.item = item
            }
        default:
            preconditionFailure("undefined whatEver")
        }
    }
    
    
}
