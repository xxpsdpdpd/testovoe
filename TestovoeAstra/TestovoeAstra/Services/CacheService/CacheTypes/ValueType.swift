//
//  ValueType.swift
//  TestovoeAstra
//
//  Created by michail on 11.02.2024.
//

import Foundation

extension CacheService {
    final class ValueType: NSObject {
        let value: Value
        
        init(_ value: Value) {
            self.value = value
        }
        
        override var hash: Int {
            return value.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? Self else {
                return false
            }
            
            return value.value == self.value
        }
    }
}
