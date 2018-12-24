import Foundation
import XCTest

@testable import acho

final class StateTests: XCTestCase {
    var subject: State<String>!

    override func setUp() {
        super.setUp()
        subject = State(options: (0 ... 10).map(String.init))
    }

    func test_when_indexIsAtTheTop() {
        let got = subject.output()
        XCTAssertEqual(got.count, 5)

        XCTAssertEqual(got[0].0, "0")
        XCTAssertEqual(got[0].1, true)

        XCTAssertEqual(got[4].0, "4")
        XCTAssertEqual(got[4].1, false)
    }

    func test_when_indexHasBeenMovedThreePositionsDown() {
        subject.down()
        subject.down()
        subject.down()
        let got = subject.output()
        XCTAssertEqual(got.count, 5)

        XCTAssertEqual(got[0].0, "3")
        XCTAssertEqual(got[0].1, true)

        XCTAssertEqual(got[4].0, "7")
        XCTAssertEqual(got[4].1, false)
    }

    func test_when_indexHasBeenMovedThreePositionsUp() {
        subject.up()
        subject.up()
        subject.up()
        let got = subject.output()
        XCTAssertEqual(got.count, 5)

        XCTAssertEqual(got[0].0, "6")
        XCTAssertEqual(got[0].1, false)

        XCTAssertEqual(got[2].0, "8")
        XCTAssertEqual(got[2].1, true)

        XCTAssertEqual(got[4].0, "10")
        XCTAssertEqual(got[4].1, false)
    }
}
