import Foundation
import XCTest

@testable import acho

final class FormatterTests: XCTestCase {
    var subject: acho.Formatter!

    override func setUp() {
        super.setUp()
        subject = Formatter()
    }

    func test_format() {
        let question = "question"
        let options = [("1", false), ("2", true), ("3", false)]
        let got = subject.format(question: question, options: options)
        print(got)
        XCTAssertEqual(got.count, 4)
        XCTAssertEqual(got[0], "question \u{1B}[33m(Choose with ↑ ↓ ⏎)\u{1B}[0m")
        XCTAssertEqual(got[1], "  1. 1")
        XCTAssertEqual(got[2], "\u{1B}[36m> 2. 2\u{1B}[0m")
        XCTAssertEqual(got[3], "  3. 3")
    }
}
