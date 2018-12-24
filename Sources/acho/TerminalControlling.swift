import Basic
import Foundation

protocol TerminalControlling {
    func moveCursor(up: Int)
    func write(_ string: String)
}

extension TerminalController: TerminalControlling {
    func write(_ string: String) {
        write(string, inColor: .noColor, bold: false)
    }
}
