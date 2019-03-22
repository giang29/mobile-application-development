import UIKit

enum InvalidValueError: Error {
    case invalidName, invalidAge, invalidHeight, invalidWeight
}

class Person {
    var name: String {
        didSet {
            if name.isEmpty {
                name = oldValue
            }
        }
    }
    var age: Int {
        didSet {
            guard age <= 130 && age >= 0 else {
                age = oldValue
                return
            }
        }
    }
    var height: Int {
        didSet {
            guard height <= 240 && height >= 20 else {
                height = oldValue
                return
            }
        }
    }
    var weight: Double {
        didSet {
            guard weight <= 200 && weight >= 1.5 else {
                weight = oldValue
                return
            }
        }
    }
    init(name: String, age: Int, height: Int, weight: Double) throws {
        guard !name.isEmpty else {
            throw InvalidValueError.invalidName
        }
        
        guard age <= 130 && age >= 0 else {
            throw InvalidValueError.invalidAge
        }
        
        guard height <= 240 && height >= 20 else {
            throw InvalidValueError.invalidHeight
        }
        
        guard weight <= 200 && weight >= 1.5 else {
            throw InvalidValueError.invalidWeight
        }
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
    }
}
