//
//  Stack.swift
//  assignment2
//
//  Created by Giang Pham on 04/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

class Stack<T> {
    private var array = [T]()
    init() {}
    func push(value: T) {
        array.append(value)
    }
    func pop() -> T? {
        if let lastElement = array.last {
            array.remove(at: array.count - 1)
            return lastElement
        }
        return nil
    }
    func peek(n: Int) -> T? {
        if (array.count < n) {
            return nil
        } else {
            return array[array.count - n]
        }
    }
    func swap() {
        let first = pop()
        let second = pop()
        if let unwrappedFirst = first {
            push(value: unwrappedFirst)
        }
        if let unwrappedSecond = second {
            push(value: unwrappedSecond)
        }
    }
}
