import ColorizeSwift
import Foundation

/// State.
class AchoState<C: CustomStringConvertible & Hashable> {
    /// Question.
    let question: String

    /// State items.
    let items: [C]

    /// Selected index
    private(set) var index: Int

    /// Initializes the state.
    ///
    /// - Parameters:
    ///   - question: State question.
    ///   - items: State items.
    init(question: String,
         items: [C]) {
        self.question = question
        self.items = items
        index = 0
    }

    /// Selects the item at the current index.
    ///
    /// - Returns: The item at the current index.
    func enter() -> C {
        return items[self.index]
    }

    /// Move the selected line one line up.
    ///
    /// - Returns: The output lines.
    func up() -> [String] {
        if index + 1 < items.count {
            index += 1
        } else {
            index = 0
        }
        return output()
    }

    /// Move the selected line one line down.
    ///
    /// - Returns: The output lines.
    func down() -> [String] {
        if index - 1 >= 0 {
            index -= 1
        } else {
            index = items.count - 1
        }
        return output()
    }

    /// Returns the terminal output for the given state.
    ///
    /// - Returns: Output lines.
    func output() -> [String] {
        var output: [String] = []
        output.append("\(question) \("(Choose with ↑ ↓ ⏎)".yellow())")
        for i in 0 ..< items.count {
            let isCurrent = i == index
            let prefix = isCurrent ? "> " : "  "
            let item = "\(prefix)\(i). \(items[i].description)"
            if isCurrent {
                output.append(item.cyan())
            } else {
                output.append(item)
            }
        }
        return output
    }
}
