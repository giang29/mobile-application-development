//
//  Queue.swift
//  assignment3
//
//  Created by Giang Pham on 04/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

class PriortyQueue<T: Comparable> {
    private let linkedlist = LinkedList<T>()
    
    func enqueue(value: T) {
        let position = linkedlist.findFirst {
            return $0 > value
        }
        do {
            try linkedlist.insert(value: value, at: position)
        } catch _ {}
    }
    
    func dequeue() -> T? {
        return linkedlist.removeFirst()
    }
}
