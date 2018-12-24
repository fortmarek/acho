import Basic
import Foundation

/// Protocol that defines the interface to interact with the terminal.
protocol TerminalControlling {
    /// Moves the cursor n lines up.
    ///
    /// - Parameter up: Number of lines to move the cursor.
    func moveCursor(up: Int)

    /// Writes the given string in the terminal.
    ///
    /// - Parameter string: String to print.
    func write(_ string: String)
}

extension TerminalController: TerminalControlling {
    /// Writes the given string in the terminal.
    ///
    /// - Parameter string: String to print.
    func write(_ string: String) {
        write(string, inColor: .noColor, bold: false)
    }
}
