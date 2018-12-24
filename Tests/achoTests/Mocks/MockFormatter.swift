@testable import acho
import Foundation

final class MockFormatter: Formatting {
    var formatStub: [String] = []

    func format(question _: String,
                options _: [(String, Bool)]) -> [String] {
        return formatStub
    }
}
