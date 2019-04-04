//
//  LinkedList.swift
//  assignment3
//
//  Created by Giang Pham on 04/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation
enum error : Error {
    case IllegalPostion
}
class Node<T> {
    let value: T
    var next: Node? = nil
    init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var head: Node<T>?
    func insert(value: T, at position: Int = -1) throws {
        if position == -1 {
            if head == nil {
                head = Node<T>(value)
            } else {
                var lastNode: Node<T> = head!
                while let next = lastNode.next {
                    lastNode = next
                }
                let newNode = Node<T>(value)
                lastNode.next = newNode
            }
        } else {
            if (head == nil && position == 0) {
                head = Node<T>(value)
            } else if (head == nil && position != 0) {
                throw error.IllegalPostion
            } else {
                var previousNode: Node<T>? = nil
                var nextNode: Node<T> = head!
                var currentPosition = 0
                while (currentPosition < position && nextNode.next != nil) {
                    previousNode = nextNode
                    nextNode = nextNode.next!
                    currentPosition+=1
                }
                if currentPosition != position {
                    throw error.IllegalPostion
                }
                let node = Node<T>(value)
                if previousNode == nil {
                    head = node
                } else {
                    previousNode!.next = node
                }
                node.next = nextNode
            }
        }
    }
    
    func removeFirst() -> T? {
        let value = head?.value
        head = head?.next
        return value
    }
    
    func findFirst(_ predicate: (T) -> Bool) -> Int {
        if (head == nil) {
            return -1
        }
        var currentPosition = 0
        var node : Node<T>? = head
        repeat {
            if(predicate(node!.value)) {
                return currentPosition
            }
            currentPosition+=1
            node = node!.next
        } while (node != nil)
        if (node == nil || !predicate(node!.value)) {
            return -1
        }
        return currentPosition
    }
}
