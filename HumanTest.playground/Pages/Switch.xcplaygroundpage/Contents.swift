//: [Previous](@previous)

import Foundation

let age = 55
var name = "Alex"

mainLoop: for _ in 0...1000  { //name of loop - main loop 
    for i in 0..<99 {
        if i == 10 {
            break mainLoop // => exit from main loop
        }
        print("/(i)")
    }
}

switch age {
case 0...16: print ("школота"); fallthrough //перекидыввает его на слеющий кейс (не проверяя его)
case 17...21: print ("студент");
case 18...50: print ("взрослота");
default:
    print ("не определено")
}

// case with additional conditions
switch name {
case "Alex" where age <= 15: print("Alex age \(age)")
case "Alex" where age > 15:  print("elder Alex age \(age)")

default:
    print ("pizdec")
}

// switch with tuple, case 3 + binding
let tuple = (name: name, age: age)
switch tuple {
case ("Alex", 15): print("Alex is young man")
case ("Alex", 50): print("Alex is old man")
case (_, let value) where value > 50 && value < 60:
    print("Alex   ex wery old man!")
case ("Alex", _): print("Alex with wild card")
default: break
}

// pattern matching with tuple (tuple buinding)
let pointTuple = (latitude: 5, longiture: 10)
switch pointTuple {
    case let (x, y) where x == y: print("latitude = longiture")
    case let (x, y) where x != y: print("latitude != longiture")
    default: break
}


