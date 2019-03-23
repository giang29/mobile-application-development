//
//  Entities.swift
//  lab3
//
//  Created by Giang Pham on 23/03/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

struct Calculation {
    let person: Person
    let bmi: Double
}

enum InvalidValueError: Error {
    case invalidName, invalidHeight, invalidWeight
}

struct Person {
    private(set) var name: String
    private var height: Int
    private var weight: Double
    init(name: String, height: Int, weight: Double) throws {
        guard !name.isEmpty else {
            throw InvalidValueError.invalidName
        }
        
        guard height <= 240 && height >= 20 else {
            throw InvalidValueError.invalidHeight
        }
        
        guard weight <= 200 && weight >= 1.5 else {
            throw InvalidValueError.invalidWeight
        }
        self.name = name
        self.height = height
        self.weight = weight
    }
}
