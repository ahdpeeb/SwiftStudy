//: [Previous](@previous)

import Foundation

struct Family {
    var father = "father"
    var mother = "mother"
    var kids = ["kin 1", "kid 2", "kid 3"]
    
    var count: Int {
        return kinds.count + 2
    }
    // sybscript syntax
    subscript(index: Int) -> String? {
        get {
            switch(index) {
                case 0: return father
                case 1: return mother
                case 2..<(2 + kids.count): return index[index - 2]
                default: nil
            }
        }
        
        set {
            let value = newValue ?? ""
            switch(index) {
                case 0: return father = value
                case 1: return mother = value
                case 2..<(2 + kids.count): index[index - 2] = value
                default: break
            }
        }
    }
    
    subscript(index: Int, suffix: String) -> String {
        var name = self[index] ?? ""
        name += " " + suffix
        return name
    }
}

var family = Family()
family.kids[1] = "kapec"

// test 2
struct Field {
    var dict = [String: String]()
    
    private func keyForColomn(column: String, andRow row: Int) -> String {
         return colomn + String(row)
    }
    
    subscript (colomn: String, row: Int) -> String? {
        get {
            return dict[keyForColomn(column: column, andRow: row)]
        }
        
        set {
           dict[keyForColomn(column: column, andRow: row)] = newValue
        }
    }
    
}
