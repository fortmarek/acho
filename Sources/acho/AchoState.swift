import ColorizeSwift
import Foundation

/// It represents the state of the prompt.
class AchoState<C: CustomStringConvertible & Hashable> {
    /// Amount of elements shown
    let span: Int = 5

    /// Prompt question.
    let question: String

    /// List of options the user can select from.
    let items: [C]

    /// Current index.
    private(set) var index: Int

    /// Initializes the state.
    ///
    /// - Parameters:
    ///   - question: Prompt question.
    ///   - items: List of options the user can select from.
    init(question: String,
         items: [C]) {
        self.question = question
        self.items = items
        index = 0
    }

    /// Selects the option at the current index.
    ///
    /// - Returns: The option at the current index.
    func select() -> C {
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

        let lowerIndex = (index + span < items.count) ? index : items.count - 1 - span
        let upperIndex = (index + span < items.count) ? index + span : items.count - 1

        for i in lowerIndex ... upperIndex {
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
