import acho

let options = (0 ... 50).map({ "Option \($0)" })
let acho = Acho<String>()
let option = acho.ask(question: "Select an option", items: options)
print(option)
