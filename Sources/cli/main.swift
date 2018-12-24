import acho

let options = (0 ... 2).map({ "Option \($0)" })
let acho = Acho<String>()
let option = acho.ask(question: "Select an option", options: options)
if let option = option {
    print(option)
}
