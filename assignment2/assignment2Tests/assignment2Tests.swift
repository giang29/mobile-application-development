//
//  assignment2Tests.swift
//  assignment2Tests
//
//  Created by Giang Pham on 04/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import XCTest
@testable import assignment2

class assignment2Tests: XCTestCase {
    
    var stack: Stack<Int>!

    override func setUp() {
        stack = Stack<Int>()
    }

    override func tearDown() {
        
    }

    func testShouldStartWithNoElement() {
        let first = stack.pop()
        assert(first == nil)
    }
    
    func testShouldAddElementInCorrectOrder() {
        stack.push(value: 1)
        stack.push(value: 2)
        stack.push(value: 3)
        let first = stack.pop()
        let second = stack.pop()
        let third = stack.pop()
        let fourth = stack.pop()
        assert(first == 3)
        assert(second == 2)
        assert(third == 1)
        assert(fourth == nil)
    }
    
    func testShouldPeekCorrectValue() {
        stack.push(value: 1)
        stack.push(value: 2)
        stack.push(value: 3)
        assert(stack.peek(n: 1) == 3)
        assert(stack.peek(n: 2) == 2)
        assert(stack.peek(n: 3) == 1)
        assert(stack.peek(n: 4) == nil)
    }
    
    func testShouldSwapCorrectly() {
        stack.push(value: 1)
        stack.push(value: 2)
        stack.push(value: 3)
        stack.swap()
        assert(stack.peek(n: 1) == 2)
        assert(stack.peek(n: 2) == 3)
        assert(stack.peek(n: 3) == 1)
    }
    
    func testShouldNotSwapIfThereIsLessThan2Elements() {
        stack.push(value: 1)
        stack.swap()
        assert(stack.pop() == 1)
        assert(stack.pop() == nil)
        stack.swap()
        assert(stack.pop() == nil)
    }
}
