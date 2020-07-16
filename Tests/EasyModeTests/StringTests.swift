@testable import EasyMode
import XCTest

final class StringTests: XCTestCase {
    func testIsFuzzyMatchedUsing() {
        XCTAssertTrue("The source string".isFuzzyMatched(using: "thesstr"))
        XCTAssertTrue("The source string".isFuzzyMatched(using: "t h e s s t r"))
        XCTAssertTrue("The source string".isFuzzyMatched(using: "ThSoString"))
        XCTAssertTrue("The source string".isFuzzyMatched(using: "TSS"))

        XCTAssertFalse("The source string".isFuzzyMatched(using: "thesastr"))
        XCTAssertFalse("The source string".isFuzzyMatched(using: "asdf"))
        XCTAssertFalse("The source string".isFuzzyMatched(using: "thessss"))
    }

    func testPresence() {
        XCTAssertNil("".presence)
        XCTAssertNotNil("a".presence)
    }

    func testIsBlank() {
        XCTAssertTrue("".isBlank)
        XCTAssertTrue("\n ".isBlank)
        XCTAssertTrue(" ".isBlank)
        XCTAssertFalse(" a".isBlank)
    }

    static var allTests = [
        ("testIsFuzzyMatchedUsing", testIsFuzzyMatchedUsing),
        ("testPresence", testPresence),
        ("testIsBlank", testIsBlank),
    ]
}
