import Basic
import Foundation

public final class Acho<C: CustomStringConvertible & Hashable> {
    /// Terminal controller.
    let terminalController: TerminalControlling

    /// Acho state.
    let state: AchoState<C>

    /// Standard input.
    let standardInput: FileHandle

    /// Public constructor that takes no arguments
    public convenience init(question: String, items: [C]) {
        precondition(items.count > 1, "there should be at least one item")
        let controller = TerminalController(stream: stdoutStream)!
        self.init(terminalController: controller,
                  state: AchoState(question: question, items: items),
                  standardInput: FileHandle.standardInput)
    }

    /// Initialize the class with its attributes
    ///
    /// - Parameters:
    ///   - terminalController: Terminal controller.
    ///   - state: State.
    init(terminalController: TerminalControlling,
         state: AchoState<C>,
         standardInput: FileHandle) {
        self.terminalController = terminalController
        self.state = state
        self.standardInput = standardInput
    }

    /// Ask questions.
    public func ask() -> C? {
        let originalTerm = enableRawMode(fileHandle: standardInput)

        defer {
            restoreRawMode(fileHandle: standardInput, originalTerm: originalTerm)
        }

        state.output().forEach({ terminalController.write("\($0)\n") })
        var char: UInt8 = 0
        var selectedItem: C?

        while read(standardInput.fileDescriptor, &char, 1) == 1 {
            if char == 0x6A || char == 0x42 { // down
                let output = state.down()
                terminalController.moveCursor(up: output.count)
                output.forEach({ terminalController.write("\($0)\n") })
            } else if char == 0x6B || char == 0x41 { // up
                let output = state.up()
                terminalController.moveCursor(up: output.count)
                output.forEach({ terminalController.write("\($0)\n") })
            } else if char == 0x0A { // enter
                selectedItem = state.enter()
                break
            } else if char == 0x04 { // detect EOF (Ctrl+D)
                break
            }
        }

        return selectedItem
    }

    // MARK: - Fileprivate

    // https://stackoverflow.com/questions/49748507/listening-to-stdin-in-swift
    // https://stackoverflow.com/questions/24146488/swift-pass-uninitialized-c-structure-to-imported-c-function/24335355#24335355
    fileprivate func initStruct<S>() -> S {
        let struct_pointer = UnsafeMutablePointer<S>.allocate(capacity: 1)
        let struct_memory = struct_pointer.pointee
        struct_pointer.deallocate()
        return struct_memory
    }

    fileprivate func enableRawMode(fileHandle: FileHandle) -> termios {
        var raw: termios = initStruct()
        tcgetattr(fileHandle.fileDescriptor, &raw)

        let original = raw

        raw.c_lflag &= ~(UInt(ECHO | ICANON))
        tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &raw)

        return original
    }

    fileprivate func restoreRawMode(fileHandle: FileHandle, originalTerm: termios) {
        var term = originalTerm
        tcsetattr(fileHandle.fileDescriptor, TCSAFLUSH, &term)
    }
}
