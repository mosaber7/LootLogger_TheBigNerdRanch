//
//  ItemStore.swift
//  LootLogger
//
//  Created by Saber on 25/01/2021.
//

import UIKit
class ItemStore{
    var allItems : [Item] = []
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    func moveItem(from fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
}
