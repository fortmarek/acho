import acho
import Foundation

/// Acho stub
fileprivate struct Stub<C: CustomStringConvertible & Hashable>: Hashable {
    let question: String
    let options: [C]

    init(question: String, options: [C]) {
        self.question = question
        self.options = options
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
        hasher.combine(options)
    }
}

/// Class that conforms the AchoProtocol and allows stubbing responses.
public class MockAcho<C: CustomStringConvertible & Hashable>: AchoProtocol {
    /// List of stubs
    fileprivate var stubs: [Stub<C>: C] = [:]

    /// Stubs acho questions.
    ///
    /// - Parameters:
    ///   - question: Question to be stubbed.
    ///   - items: Question items to be stubbed.
    ///   - with: Response for the given question & items
    public func stub(question: String, items: [C], with: C?) {
        let stub: Stub<C> = Stub(question: question, options: items)
        stubs[stub] = with
    }

    public func ask(question: String, options: [C]) -> C? {
        let stub: Stub<C> = Stub(question: question, options: options)
        return stubs[stub]
    }
}
