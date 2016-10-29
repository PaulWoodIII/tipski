//
//  Emoji.swift
//  Tipski
//
//  Created by Paul Wood on 10/29/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

import Foundation

class Emoji {
    var title : String
    var keywords : [String]
    var char : String
    var category : String
    var fts : String
    
    init(title incTitle: String, dictionary : [String: Any]){
        title = incTitle
        keywords = dictionary["keywords"] as! [String]
        char = dictionary["char"] as! String
        category = dictionary["category"] as! String
        var composing = keywords.joined(separator: "|")
        composing = title + composing
        composing = char + composing
        composing = category + composing
        fts = composing
    }
    
    let allEmojis : [Emoji] = {
        let url = Bundle.main.url(forResource: "emojis", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let emojiDict = json as! [String: Any]
        var emojis = [Emoji]()
        for key in emojiDict.keys {
            let dict = emojiDict[key] as! [String:Any]
            let e = Emoji(title: key, dictionary:dict)
            emojis.append(e)
        }
        return emojis
    }()
}

extension Emoji : CustomStringConvertible {
    public var description: String {
        get {
            return "\(title): \(char)"
        }
    }
}
