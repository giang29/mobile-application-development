import UIKit

//EXPERIMENT
//Create a constant with an explicit type of Float and a value of 4.
var explitFloatNumberFour : Float = 4

//EXPERIMENT
//Try removing the conversion to String from the last line. What error do you get?
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
// let widthLabel = label + width ==> ERROR: binary operator '+' cannot be applied to operands of type 'String' and 'Int'

let moneyInBankAccount : Float = 450
let cash : Float = 22.5

//EXPERIMENT
//Use \() to include a floating-point calculation in a string and to include someone’s name in a greeting.
print("My name is Student X, I have total of \(moneyInBankAccount + cash) euros")

//EXPERIMENT
//Change optionalName to nil. What greeting do you get? Add an else clause that sets a different greeting if optionalName is nil.
var optionalName: String? = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

//EXPERIMENT
//Try removing the default case. What error do you get?
// switch MUST BE exhaustive
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

//EXPERIMENT
//Add another variable to keep track of which kind of number was the largest, as well as what that largest number was.
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var numberKind = "Prime"
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            numberKind = kind
        }
    }
}
print(numberKind, largest)

//EXPERIMENT
//Remove the day parameter. Add a parameter to include today’s lunch special in the greeting.
func greet(person: String, lunchSpecial: String) -> String {
    return "Hello \(person), today's lunch special is \(lunchSpecial)."
}
greet(person: "Bob", lunchSpecial: "not Sodexo lunch")

//EXPERIMENT
//Rewrite the closure to return zero for all odd numbers.
let numbers = [20, 19, 7, 12]
numbers.map({ (number: Int) -> Int in
    if number % 2 != 0 {
        return 0
    }
    return number
})

//EXPERIMENT
//Add a constant property with let, and add another method that takes an argument.
class Shape {
    let area : Float = 50
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    func isBiggerThan(_ area: Float) -> Bool {
        return self.area > area
    }
}

//EXPERIMENT
//Make another subclass of NamedShape called Circle that takes a radius and a name as arguments to its initializer. Implement an area() and a simpleDescription() method on the Circle class.
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Circle: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return .pi * radius * radius
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius of \(radius)."
    }
}

//EXPERIMENT
//Write a function that compares two Rank values by comparing their raw values.
enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    func compareTo(_ other: Rank) -> Int {
        if self.rawValue < other.rawValue {
            return -1
        } else if self.rawValue == other.rawValue {
            return 0
        } else {
            return 1
        }
    }
}

//EXPERIMENT
//Add a color() method to Suit that returns “black” for spades and clubs, and returns “red” for hearts and diamonds.
enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        if self == .spades || self == .hearts {
            return "Black"
        } else {
            return "Red"
        }
    }
}

//EXPERIMENT
//Add a third case to ServerResponse and to the switch.
enum ServerResponse {
    case result(String, String)
    case redirect
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case .redirect:
    print("Redirected...")
case let .failure(message):
    print("Failure...  \(message)")
}

//EXPERIMENT
//Write a function that returns an array containing a full deck of cards, with one card of each combination of rank and suit.
struct Card: Hashable {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    static func deck() -> Set<Card> {
        var deck: Set<Card> = []
        Rank.allCases.forEach { rank in
            Suit.allCases.forEach {suit in
                deck = deck.union([Card(rank: rank, suit: suit)])
            }
        }
        return deck
    }
}
Card.deck().count == 52
