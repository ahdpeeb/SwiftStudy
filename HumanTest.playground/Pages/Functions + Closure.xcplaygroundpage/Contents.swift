//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

// out function adopt string and another function, which return Int, w
func doSomethingWith(string: String, function: ()->(Int)) {
    let intValue = function()
    print("\(string) + \(String(intValue))")
}

// call it
doSomethingWith(string: "fuck") { () -> (Int) in
    return 10
}

let intArray:[Int] = [1, 2, 3, 4, 5]

func itereteArray(array: [Int]) {
    for value in array {
        print("\(String(value))")
    }
}

// inout function (скоуп функции меняет наружное значение переменной)
var intValue1 = 10
var intValue2 = 14

func swapTwoInts(_ value1: inout Int, _ value2: inout Int) {
    let tempValue1 = value1
    value1 = value2
    value2 = tempValue1;
}

swapTwoInts(&intValue1, &intValue2)
print("intValue1 = \(intValue1), intValue2 = \(intValue2)")

//closure
let unsortedNames = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let sortedNames = unsortedNames.sorted(by: { (value1: String, value2: String) -> Bool in
    return value2 > value1
    })

let sortedNames2 = unsortedNames.sorted(by: {$0 > $1})
print("\(sortedNames2)")

func filterStrings(strings: [String], block: (String) -> (Bool)) -> [String] {
    var stringArray = [String]()
    for str in strings {
        if block(str) {
            stringArray.append(str)
        }
    }
    return stringArray
}

// ниже две аналогичные записи, $0 - можно сократить, как во втором варианте
let result1 = filterStrings(strings: unsortedNames) { (value: String) -> (Bool) in
    value.hasPrefix("A")
}
print("\(result1)")

let result2 = filterStrings(strings: unsortedNames) { $0.hasPrefix("A") }
print("\(result2)")

