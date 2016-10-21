//: Playground - noun: a place where people can play

import UIKit
import Foundation

enum genderType {
    case male
    case female
    case value (String)
}

class Human {
    var fullName: String! = nil
    var age = 0
    var children: [Human] = [Human]()
    
    init() {
        
    }
    
    init(fullName: String, age: Int) {
        self.fullName = fullName
        self.age = age
    }
    
    func sayPhrase(phrase: String) -> (){
        print("\(self) say \(phrase)")
    }
    
    func createChild(child: Human) -> (Human){
        let person = Human()
        self.children += [person]
        
        return person
    }
}

var bliaMan = Human(fullName: "Pizdec", age: 23)
bliaMan.sayPhrase(phrase: "Dcem pizdec")

var child = bliaMan.createChild(child: Human(fullName: "Bob", age: 1))

print(bliaMan.children.count)
