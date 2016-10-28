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
    var barTipEmojis : Array<TipEmoji>!
    var taxiTipEmojis : Array<TipEmoji>!
    var maidTipEmojis : Array<TipEmoji>!
    var bellHopTipEmojis : Array<TipEmoji>!
    
    init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = paths.stringByAppendingPathComponent(path: "tipEmoji.plist")
        let _emojis = NSKeyedUnarchiver.unarchiveObject(withFile: path)
        guard let emojis = _emojis as? [String:Array<TipEmoji>]!,
            emojis != nil else {
            tipEmojis = defaultList
            barTipEmojis = defaultBartenderList
            taxiTipEmojis = defaultTaxiList
            maidTipEmojis = defaultMaidList
            bellHopTipEmojis = defaultBellHopList
            return
        }
        tipEmojis = emojis["WaitStaff"]!
        barTipEmojis = emojis["BarTender"]!
        taxiTipEmojis = emojis["Taxi"]!
        maidTipEmojis = emojis["Maid"]!
        bellHopTipEmojis = emojis["BellHop"]!
    }

    func persist(){
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let path = paths.stringByAppendingPathComponent(path: "tipEmoji.plist")
        let composed : [String:Array<TipEmoji>] = [
            "WaitStaff":tipEmojis,
            "BarTender":barTipEmojis,
            "Taxi":taxiTipEmojis,
            "Maid":maidTipEmojis,
            "BellHop":bellHopTipEmojis
        ]
        if !NSKeyedArchiver.archiveRootObject(composed, toFile: path){
            fatalError("Could Not persist")
        }
 
    }

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
    
    let defaultBartenderList : [TipEmoji]! = {
        
        return [
            TipEmoji(emoji:"😷",tipAmount:0.0),
            TipEmoji(emoji:"😭",tipAmount:0.25),
            TipEmoji(emoji:"😕",tipAmount:0.50),
            TipEmoji(emoji:"😶",tipAmount:1.0),
            TipEmoji(emoji:"🙂",tipAmount:1.5),
            TipEmoji(emoji:"😀",tipAmount:2.0),
            TipEmoji(emoji:"😍",tipAmount:3.0)
        ]
    }()
    
    let defaultTaxiList : [TipEmoji]! = {
        
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
    
    let defaultMaidList : [TipEmoji]! = {
        
        return [
            TipEmoji(emoji:"😷",tipAmount:0.0),
            TipEmoji(emoji:"😭",tipAmount:0.25),
            TipEmoji(emoji:"😕",tipAmount:0.50),
            TipEmoji(emoji:"😶",tipAmount:1.0),
            TipEmoji(emoji:"🙂",tipAmount:1.5),
            TipEmoji(emoji:"😀",tipAmount:2.0),
            TipEmoji(emoji:"😍",tipAmount:3.0)
        ]
    }()
    
    let defaultBellHopList : [TipEmoji]! = {
        
        return [
            TipEmoji(emoji:"😷",tipAmount:0.0),
            TipEmoji(emoji:"😭",tipAmount:0.25),
            TipEmoji(emoji:"😕",tipAmount:0.75),
            TipEmoji(emoji:"😶",tipAmount:1.0),
            TipEmoji(emoji:"🙂",tipAmount:1.25),
            TipEmoji(emoji:"😀",tipAmount:1.5),
            TipEmoji(emoji:"😍",tipAmount:2.0)
        ]
    }()
    
}
