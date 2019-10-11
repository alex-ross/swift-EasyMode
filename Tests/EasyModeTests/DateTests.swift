import XCTest
@testable import EasyMode

class DateTests: XCTestCase {
    func testStartOfWeek() {
        let current = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 28).date!
        let expected = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 26).date!

        XCTAssertEqual(expected, current.startOfWeek)
    }

    func testEndOfWeek() {
        let current = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 28).date!
        let expected = DateComponents(calendar: Calendar.current, year: 2019, month: 9, day: 1).date!

        XCTAssertEqual(expected, current.endOfWeek)
    }

    func testEndOfLastWeek() {
        let current = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 28).date!
        let expected = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 25).date!

        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: current)!

        XCTAssertEqual(expected, oneWeekAgo.endOfWeek)
    }

    func testIsoDate() {
        let date = DateComponents(calendar: Calendar.current, year: 2019, month: 8, day: 6).date!

        XCTAssertEqual("2019-08-06", date.isoDate)
    }

    func testIsoDateWhenSunday() {
        let date = DateComponents(calendar: Calendar.current, year: 2019, month: 9, day: 8).date!

        XCTAssertEqual("2019-09-08", date.endOfWeek.isoDate)
    }
    
    static var allTests = [
       ("testStartOfWeek", testStartOfWeek),
       ("testEndOfWeek", testEndOfWeek),
       ("testEndOfLastWeek", testEndOfLastWeek),
       ("testIsoDate", testIsoDate),
       ("testIsoDateWhenSunday", testIsoDateWhenSunday),
   ]
}
