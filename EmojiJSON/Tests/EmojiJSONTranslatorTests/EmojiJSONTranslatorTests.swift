import XCTest
@testable import EmojiJSONTranslator

class EmojiJSONTranslatorTests: XCTestCase {
    func testStaticsExist() {
        //Given / When the package is loaded into memory by the OS
        
        //Then
        XCTAssertEqual(Emoji.allEmojis.count, 1284)
        XCTAssertNotNil(Emoji.json)
        
    }
    
    func testPersistance () {
        let helper = FileSaver()

        //Given
        //let fixture = "Tests/EmojiJSONTranslatorTests/TestDictJSON.json"
        let fixture = "Sources/EmojiJSONTranslator/emojis.json"
        
        do {
            let dict = try?
                helper.loadJSONDictionary(filename: fixture)
            // do something with data
            // if the call fails, the catch block is executed
            XCTAssertNotNil(dict)
            print(dict)
        } catch {
            XCTFail("Should not throw an error when loading " + error.localizedDescription)
        }
        
    }


    static var allTests : [(String, (EmojiJSONTranslatorTests) -> () throws -> Void)] {
        return [
            ("testStaticsExist", testStaticsExist ),
             ("testPersistance", testPersistance),
        ]
    }
}
