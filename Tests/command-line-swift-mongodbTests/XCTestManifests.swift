import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(command_line_swift_mongodbTests.allTests),
    ]
}
#endif

