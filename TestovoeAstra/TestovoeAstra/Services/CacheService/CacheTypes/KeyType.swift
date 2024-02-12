//
//  KeyType.swift
//  TestovoeAstra
//
//  Created by michail on 11.02.2024.
//

import Foundation

extension CacheService {
    final class KeyType: NSObject {
        let keyValye: Key
        
        init(_ value: Key) {
            self.keyValye = value
        }
        
        override var hash: Int {
            return keyValye.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? Self else {
                return false
            }
            
            return value.keyValye == keyValye
        }
    }
}
