import XCTest
@testable import EmojiJSONTranslator

class EmojiJSONTranslatorTests: XCTestCase {
    func testExample() {
        
        XCTAssertEqual(Emoji.allEmojis.count, 1284)
        XCTAssertNotNil(Emoji.json)
        print(Emoji.json)
    }


    static var allTests : [(String, (EmojiJSONTranslatorTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
