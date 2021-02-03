//
//  Item.swift
//  LootLogger
//
//  Created by Saber on 25/01/2021.
//

import UIKit


class Item: Equatable, Codable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.serialNumber == rhs.serialNumber && lhs.valueInDollar == rhs.valueInDollar && lhs.dateCreated == rhs.dateCreated
    }
    
    var name: String
    var valueInDollar: Int
    var serialNumber: String?
    let dateCreated: Date
    var isCheeperTHanFifty : Bool
    init(name: String, valueInDollar: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollar = valueInDollar
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        isCheeperTHanFifty = valueInDollar <= 50 ? true : false
    }
    convenience init(random: Bool = false){
        if random{
            let adjectives = ["Fluffydddddddddddddddddddddddddddddddddddddddfdsfsfsfwef", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0...99)
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "_").first!

            self.init(name: randomName, valueInDollar: randomValue, serialNumber: randomSerialNumber)
            isCheeperTHanFifty = valueInDollar <= 50 ? true : false

        }
        else{
            self.init(name: "", valueInDollar: 0, serialNumber: nil)
            isCheeperTHanFifty = false
        }
    }
    
    
    
}
