//
//  LiveData.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

typealias CompletionHandler<T> = ((T?) -> Void)
class LiveData<T> {
    
    var value : T? = nil {
        didSet {
            notify(value)
        }
    }
    
    private var observers = [CompletionHandler<T>]()
    
    public func observe(completionHandler: @escaping CompletionHandler<T>) {
        observers.append(completionHandler)
        completionHandler(value)
    }
    
    private func notify(_ value: T?) {
        observers.forEach {
            $0(value)
        }
    }
    
    deinit {
        observers.removeAll()
    }
}
