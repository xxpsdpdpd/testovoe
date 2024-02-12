//
//  MockCacheSerivce.swift
//  TestovoeAstraTests
//
//  Created by michail on 12.02.2024.
//

import Foundation
@testable import TestovoeAstra

final class MockCacheService<Key: Hashable, Value: Hashable>: Cache {
    private var cache: [Key: Value] = [:]
    private let concurrentQueue = DispatchQueue(label: "com.dispatchCacheService.test", attributes: .concurrent)
    
    func getObject(key: Key, closure: @escaping ObjectResultType<Value>) {
        concurrentQueue.async(flags: .barrier) {
            if let value = self.cache[key] {
                closure(value, nil)
            } else {
                closure(nil, .noValueForKey)
            }
        }
    }

    func storeObject(key: Key, value: Value) {
        concurrentQueue.async(flags: .barrier) {
            self.cache[key] = value
        }
    }
}
