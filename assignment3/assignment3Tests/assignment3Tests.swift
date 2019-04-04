//
//  assignment3Tests.swift
//  assignment3Tests
//
//  Created by Giang Pham on 04/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import XCTest
@testable import assignment3

class assignment3Tests: XCTestCase {

    private var queue: PriortyQueue<Int>!
    override func setUp() {
        queue = PriortyQueue<Int>()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBeginWithNothing() {
        assert(queue.dequeue() == nil)
    }
    
    func testShouldDequeueInCorrectOrder() {
        queue.enqueue(value: 10)
        queue.enqueue(value: 5)
        queue.enqueue(value: 12)
        queue.enqueue(value: -1)
        assert(queue.dequeue() == -1)
        assert(queue.dequeue() == 5)
        assert(queue.dequeue() == 10)
        assert(queue.dequeue() == 12)
        assert(queue.dequeue() == nil)
    }

}
