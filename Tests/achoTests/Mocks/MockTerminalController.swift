import Foundation

@testable import acho

final class MockTerminalController: TerminalControlling {
    enum Event: Equatable {
        case cursorUp(Int)
        case write(String)
        case clearLine

        static func == (lhs: Event, rhs: Event) -> Bool {
            switch (lhs, rhs) {
            case let (.cursorUp(lhsUp), .cursorUp(rhsUp)):
                return lhsUp == rhsUp
            case let (.write(lhsLine), .write(rhsLine)):
                return lhsLine == rhsLine
            case (.clearLine, .clearLine):
                return true
            default:
                return false
            }
        }
    }

    var stub: ((Event) -> Void)?

    func moveCursor(up: Int) {
        stub?(.cursorUp(up))
    }

    func write(_ string: String) {
        stub?(.write(string))
    }

    func clearLine() {
        stub?(.clearLine)
    }
}
