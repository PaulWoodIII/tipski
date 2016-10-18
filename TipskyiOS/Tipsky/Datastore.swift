//
//  Datastore.swift
//  Tipski
//
//  Created by Paul Wood on 10/18/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation

final class Datastore {
    
    static let shared = Datastore()
    
    var tipEmojis : Array<TipEmoji>!
    
    let defaultList : [TipEmoji]! = {
        
        return [
            TipEmoji(emoji:"😷",tipAmount:0.0),
            TipEmoji(emoji:"😭",tipAmount:0.01),
            TipEmoji(emoji:"😕",tipAmount:0.08),
            TipEmoji(emoji:"😶",tipAmount:0.12),
            TipEmoji(emoji:"🙂",tipAmount:0.15),
            TipEmoji(emoji:"😀",tipAmount:0.18),
            TipEmoji(emoji:"😍",tipAmount:0.5)
        ]
    }()
    
    init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = paths.stringByAppendingPathComponent(path: "tipEmoji.plist")
        let _emojis = NSKeyedUnarchiver.unarchiveObject(withFile: path)
        guard let emojis = _emojis as? [TipEmoji]!,
            emojis != nil else {
            tipEmojis = defaultList
            return
        }
        tipEmojis = emojis
    }

    func persist(){
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let path = paths.stringByAppendingPathComponent(path: "tipEmoji.plist")
        if !NSKeyedArchiver.archiveRootObject(tipEmojis, toFile: path){
            fatalError("Could Not persist")
        }
 
    }
    
}
