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
        state.output().forEach({ terminalController.write("\($0)\n") })
        var selectedItem: C?

        keyReader.subscribe { event in
            switch event {
            case .down:
                let output = state.down()
                terminalController.moveCursor(up: output.count)
                output.forEach({ terminalController.write("\($0)\n") })
            case .up:
                let output = state.up()
                terminalController.moveCursor(up: output.count)
                output.forEach({ terminalController.write("\($0)\n") })
            case .select:
                selectedItem = state.select()
            case .exit:
                break
            }
        }
        return selectedItem
    }
}
