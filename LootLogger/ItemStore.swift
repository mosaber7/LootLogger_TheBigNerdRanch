//
//  ItemStore.swift
//  LootLogger
//
//  Created by Saber on 25/01/2021.
//

import UIKit
class ItemStore{
    var allItems : [[Item]] = [[],[]]
    
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        if newItem.isCheeperTHanFifty{
            allItems[0].append(newItem)
        }
        else if !newItem.isCheeperTHanFifty{
            allItems[1].append(newItem)
        }
        
        return newItem
    }
    func removeItem(_ item: Item){
        if item.isCheeperTHanFifty{
            if let index = allItems[0].firstIndex(of: item){
                allItems[0].remove(at: index)
            }
            
        }
        else if !item.isCheeperTHanFifty{
            if let index = allItems[1].firstIndex(of: item){
                allItems[1].remove(at: index)
            }
        }

    }
    func moveItem(from fromIndex: Int, toIndex: Int, fromSection : Int, toSection: Int){
        if fromIndex == toIndex || fromSection != toSection{
            return
        }
        let movedItem = allItems[fromSection][fromIndex]
        allItems[fromSection].remove(at: fromIndex)

        if movedItem.isCheeperTHanFifty{
            allItems[0].insert(movedItem, at: toIndex)
            
        }
        else{
            allItems[1].insert(movedItem, at: toIndex)}
    }
    
    @objc func saveChanges()->Bool{
        do {
            print("saving data to \(itemArchiveURL)")
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            try data.write(to: itemArchiveURL, options: [.atomic])
            return true
        } catch  let encodingError{
            print("erroer encoding some data \(encodingError)")
            return false
        }
    }
    
    init() {
        do {
                let data = try Data(contentsOf: itemArchiveURL)
                let unarchiver = PropertyListDecoder()
                let items = try unarchiver.decode([[Item]].self, from: data)
                allItems = items
            print(allItems.description)
        } catch{
            print("Error reading in saved items \(error)")
        }
        
        
        let notifactionCenter = NotificationCenter.default
        notifactionCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
        
    }
    
}
