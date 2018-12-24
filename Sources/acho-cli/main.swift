import acho
import Foundation

let simulators = ["iPhone 10", "iPhone 7"]
let acho = Acho(question: "In which simulator would you like to run the app?",
                items: simulators)
let simulator = acho.ask()
