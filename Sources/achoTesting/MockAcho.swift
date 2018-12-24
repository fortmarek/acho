import acho
import Foundation

/// Acho stub
fileprivate struct Stub<C: CustomStringConvertible & Hashable>: Hashable {
    let question: String
    let items: [C]

    init(question: String, items: [C]) {
        self.question = question
        self.items = items
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
        hasher.combine(items)
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
        let stub: Stub<C> = Stub(question: question, items: items)
        stubs[stub] = with
    }

    public func ask(question: String, items: [C]) -> C? {
        let stub: Stub<C> = Stub(question: question, items: items)
        return stubs[stub]
    }
}
