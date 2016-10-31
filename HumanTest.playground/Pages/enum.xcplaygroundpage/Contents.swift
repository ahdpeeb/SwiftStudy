
import Foundation

enum Action {
    case Run(time: Double, speed: Int) //assosiated value
    case Stop
    case Walk
    case Turn (direction:Direction)    ////assosiated value as second enum
    
    enum Direction {       //(Nested enum)
        case Left
        case Right
    }
}

let value = Action.Stop
var blabla = Action.Run(time: 2.2, speed: 10)

switch blabla {
case .Run(let time, let speed):
    print("Run time \(time), with speed \(speed)") //разбандили значения
    
case .Stop: print("Stop")
    
case .Walk: print("Walk")
    
case .Turn(let direction) where direction == .Left:
    print("turn left")
    
case .Turn(let direction) where direction == .Right:
    print("turn right")
    
    default:break
}

//inheritance from string
enum Direction : String {
    case Left     = "Left"
    case Right    = "Right"
}
   // get balue "rawValue  "
print("\(Direction.Left.rawValue)")
var directionValue = Direction(rawValue: "Left")

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// In the example above, Planet.mercury has an explicit raw value of 1, Planet.venus has an implicit raw value of 2, and so on.


