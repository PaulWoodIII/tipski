//
//  TipEmojis.swift
//  Tipski
//
//  Created by Paul Wood on 10/18/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation

class TipEmoji: NSObject, NSCoding {
    
    var tipAmount : Double
    var emoji : String
    
    init(emoji : String, tipAmount : Double) {
        self.tipAmount = tipAmount
        self.emoji = emoji
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(emoji, forKey: "emoji")
        aCoder.encode(tipAmount, forKey: "tipAmount")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        let tip = aDecoder.decodeDouble(forKey: "tipAmount")
        guard
            let emoji = aDecoder.decodeObject(forKey: "emoji") as? String else {
            return nil
        }
        
        self.tipAmount = tip
        self.emoji = emoji
    }
    
    func isValid() -> Bool {
        return self.emoji.isEmoji
    }
    
}
