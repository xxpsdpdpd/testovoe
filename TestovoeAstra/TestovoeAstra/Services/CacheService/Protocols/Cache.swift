//
//  Cache.swift
//  TestovoeAstra
//
//  Created by michail on 11.02.2024.
//

import Foundation

typealias ObjectResultType<T> = (T?, CacheWorkerError?) -> Void

protocol Cache {
    associatedtype Key
    associatedtype Value
    
    func getObject(key: Key, closure: @escaping ObjectResultType<Value>)
    func storeObject(key: Key, value: Value)
}
