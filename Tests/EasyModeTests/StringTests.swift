import XCTest
@testable import EasyMode

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

    static var allTests = [
        ("testIsFuzzyMatchedUsing", testIsFuzzyMatchedUsing),
    ]
}
