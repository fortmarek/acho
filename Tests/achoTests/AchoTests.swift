import Foundation
import XCTest

@testable import acho

final class AchoTests: XCTestCase {
    var terminalController: MockTerminalController!
    var keyReader: MockKeyReader!
    var formatter: MockFormatter!
    var subject: Acho<String>!

    override func setUp() {
        super.setUp()
        terminalController = MockTerminalController()
        keyReader = MockKeyReader()
        formatter = MockFormatter()
        subject = Acho(terminalController: terminalController,
                       keyReader: keyReader,
                       formatter: formatter)
    }

    func test_ask() {
        formatter.formatStub = ["a", "b", "c"]
        keyReader.stub(events: [.down, .select])

        var terminalEvents: [MockTerminalController.Event] = []

        terminalController.stub = { event in
            terminalEvents.append(event)
        }

        let got = subject.ask(question: "what", options: ["a", "b", "c"])

        XCTAssertEqual(got, "b")

        let expectedEvents: [MockTerminalController.Event] = [
            .clearLine,
            .write("a\n"),
            .clearLine,
            .write("b\n"),
            .clearLine,
            .write("c\n"),

            .cursorUp(3),

            .clearLine,
            .write("a\n"),
            .clearLine,
            .write("b\n"),
            .clearLine,
            .write("c\n"),

            .cursorUp(1),
            .clearLine,
            .cursorUp(1),
            .clearLine,
            .cursorUp(1),
            .clearLine,
        ]
        XCTAssertEqual(terminalEvents, expectedEvents)
    }
}
