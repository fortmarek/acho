import Basic
import Foundation

/// Protocol that defines an interface to ask the user to choose an option from a given list.
public protocol AchoProtocol {
    associatedtype C

    /// Prints the question and the options in the terminal and subscribes to key events
    /// to move the selection up and down. When the user presses enter, it returns
    /// the selected option.
    ///
    /// - Parameters:
    ///   - question: Question to be asked.
    ///   - items: List of options
    /// - Returns: Selectd option (if any).
    func ask(question: String, items: [C]) -> C?
}

/// Public interface of the library.
public final class Acho<C: CustomStringConvertible & Hashable>: AchoProtocol {
    /// Terminal controller.
    let terminalController: TerminalControlling

    /// Key reader.
    let keyReader: KeyReading

    /// Public constructor that takes no arguments
    public convenience init() {
        let controller = TerminalController(stream: stdoutStream as! LocalFileOutputByteStream)!
        self.init(terminalController: controller,
                  keyReader: KeyReader())
    }

    /// Initialize the class with its attributes
    ///
    /// - Parameters:
    ///   - terminalController: Terminal controller.
    ///   - keyReader: Instance to subscribe to key events.
    init(terminalController: TerminalControlling,
         keyReader: KeyReading) {
        self.terminalController = terminalController
        self.keyReader = keyReader
    }

    /// Prints the question and the options in the terminal and subscribes to key events
    /// to move the selection up and down. When the user presses enter, it returns
    /// the selected option.
    ///
    /// - Parameters:
    ///   - question: Question to be asked.
    ///   - items: List of options
    /// - Returns: Selectd option (if any).
    public func ask(question: String, items: [C]) -> C? {
        precondition(items.count > 1, "there should be at least one item")

        let state = AchoState(question: question, items: items)
        print(output: state.output(), first: true)
        var selectedItem: C?

        keyReader.subscribe { event in
            switch event {
            case .down:
                print(output: state.down())
            case .up:
                print(output: state.up())
            case .select:
                selectedItem = state.select()
            case .exit:
                break
            }
        }

        clear(lines: items.count)
        return selectedItem
    }

    /// Clears the last n lines from the terminal.
    ///
    /// - Parameter lines: Number of lines to be cleared.
    fileprivate func clear(lines: Int) {
        for _ in 0 ... lines {
            terminalController.moveCursor(up: 1)
            terminalController.clearLine()
        }
    }

    /// Prints the state output in the terminal.
    ///
    /// - Parameters:
    ///   - output: Output to be printed.
    ///   - first: True if it's the first print.
    fileprivate func print(output: [String], first: Bool = false) {
        if !first {
            terminalController.moveCursor(up: output.count)
        }
        output.forEach({
            terminalController.clearLine()
            terminalController.write("\($0)\n")
        })
    }
}
