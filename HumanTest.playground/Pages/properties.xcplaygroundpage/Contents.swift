//: [Previous](@previous)

import Foundation
//global const variable -
let MaxNameLength = 100;

struct Student {
    var firstName: String {
        willSet(newFirstName) {
            print("firstName will set")
        }
        
        didSet(oldFirstName) {
            print("firstName did set")
        }
    }
    // properfy static - свойства самого типа (Student.maxAge )
    static let maxAge: Int = 100;
    var age: Int {
        willSet(newAge) {
            if newAge > Student.maxAge {
                return;
            }
        }
    }
    
    static var hands = 2;
    
}

var student = Student(firstName: "bob", age: 30)
student.firstName = "Marley"

//_________________________________________________

struct Cat {
    var name: String
    var age: Int
}

var cat = Cat(name: "Murchic", age: 5)

//___________Enum_____________________
// enum can have stored propyrtyes
enum Ditection {
    static let enumDescriprion = "Directions"
    
    case Left
    case Right
    case Top
    case Botton
}

// classes can not have stored properties. the have computed properties

class Child {
    //lazy stored property - первоначальное значение nil, инициализация, когда к ним обратишься (потом оно заполнится) - обязательно переменная тип Var
     lazy var stotyOfMyLife: String = "123456789"
    
    // type "class" means computed properties for class
    class var maxAge: Int {
        return 100
    }
    
   
    
}
