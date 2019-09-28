import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EasyModeTests.allTests),
        testCase(StringTests.allTests)
    ]
}
#endif
