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
    
    static let allEmojis : [Emoji] = {
//        let url = Bundle.main.url(forResource: "emojis", withExtension: "json")
//        let data = try! Data(contentsOf: url!)
//        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
//        let emojiDict = json as! [String: Any]
        let emojiDict = Emojis().values
        var emojis = [Emoji]()
        for key in emojiDict.keys {
            let dict = emojiDict[key] as! [String:Any]
            let e = Emoji(title: key, dictionary:dict)
            emojis.append(e)
        }
        return emojis
    }()
    
    static let json : String = {
        let emojiDicts = Emoji.allEmojis.map({ (e) -> [String:Any] in
            return e.dictionary
        })
        let kVal = ["emoji":emojiDicts]
        let data = try! JSONSerialization.data(withJSONObject: kVal, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)!
    }()
    
    
    var dictionary : [String:Any] {
        get {
            return ["t":title,
                    "k":keywords,
                    "c":char,
                    "x":category]
        }
    }
    

}

extension Emoji : CustomStringConvertible {
    public var description: String {
        get {
            return "\(title): \(char)"
        }
    }
}

extension String {
    public var isEmoji : Bool {
        get {
            return Emoji.allEmojis.contains(where: { (e) -> Bool in
                return e.char == self
            })
        }
    }
}


