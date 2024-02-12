//
//  CacheService.swift
//  TestovoeAstra
//
//  Created by michail on 11.02.2024.
//

import Foundation

final class CacheService<Key: Hashable, Value: Hashable>: Cache {
    private let cache = NSCache<KeyType, ValueType>()
    private let concurrentQueue = DispatchQueue(label: "com.dispatchCacheService", attributes: .concurrent)
    
    func getObject(key: Key, closure: @escaping ObjectResultType<Value>) {
        concurrentQueue.async(flags: .barrier) {
            let cacheKey: KeyType = .init(key)
            if let object = self.cache.object(forKey: cacheKey) {
                closure(object.value, nil)
            } else {
                closure(nil, .noValueForKey)
            }
        }
    }

    func storeObject(key: Key, value: Value) {
        concurrentQueue.async(flags: .barrier) {
            let cacheKey: KeyType = .init(key)
            let object: ValueType = .init(value)
            self.cache.setObject(object, forKey: cacheKey)
        }
    }
}
