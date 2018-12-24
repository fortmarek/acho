import Basic
import Foundation

/// Public interface of the library.
public final class Acho<C: CustomStringConvertible & Hashable> {
    /// Terminal controller.
    let terminalController: TerminalControlling

    /// Acho state.
    let state: AchoState<C>

    /// Key reader.
    let keyReader: KeyReading

    /// Public constructor that takes no arguments
    public convenience init(question: String, items: [C]) {
        precondition(items.count > 1, "there should be at least one item")
        let controller = TerminalController(stream: stdoutStream)!
        self.init(terminalController: controller,
                  state: AchoState(question: question, items: items),
                  keyReader: KeyReader())
    }

    /// Initialize the class with its attributes
    ///
    /// - Parameters:
    ///   - terminalController: Terminal controller.
    ///   - state: State.
    init(terminalController: TerminalControlling,
         state: AchoState<C>,
         keyReader: KeyReading) {
        self.terminalController = terminalController
        self.state = state
        self.keyReader = keyReader
    }

    /// Prints the question and the options in the terminal and subscribes to key events
    /// to move the selection up and down. When the user presses enter, it returns
    /// the selected option.
    ///
    /// - Returns: Selected option (if any)
    public func ask() -> C? {
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
