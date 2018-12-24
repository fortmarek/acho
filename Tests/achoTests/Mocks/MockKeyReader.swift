@testable import acho
import Foundation

final class MockKeyReader: KeyReading {
    fileprivate var stubs: [KeyEvent] = []

    func subscribe(subscriber: @escaping (KeyEvent) -> Void) {
        stubs.forEach({ subscriber($0) })
    }

    func stub(events: [KeyEvent]) {
        stubs = events
    }
}
