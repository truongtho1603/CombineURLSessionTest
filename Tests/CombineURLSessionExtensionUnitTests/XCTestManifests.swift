import XCTest

#if !canImport(Swift)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CombineURLSessionTestTests.allTests)
    ]
}
#endif
