@testable import EasyMode
import XCTest

final class ArrayTests: XCTestCase {
    func testGroupedByNumberOfElements() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let expected = [[1, 2, 3, 4], [5, 6, 7, 8], [9]]

        XCTAssertEqual(expected, array.grouped(byNumberOfElements: 4))
    }

    static var allTests = [
        ("testGroupedByNumberOfElements", testGroupedByNumberOfElements),
    ]
}
