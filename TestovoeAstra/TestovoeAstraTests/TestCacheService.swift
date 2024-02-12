//
//  TestCacheService.swift
//  TestovoeAstraTests
//
//  Created by michail on 12.02.2024.
//

import Foundation
@testable import TestovoeAstra
import XCTest

final class TestCacheService: XCTestCase {
    func testMultithreadGetStoreCacheObject() throws {
        let expectation = XCTestExpectation(description: #function)
        let cacheManager = MockCacheService<Int, Int>()
        
        let numberOfTries = 20
        var counter = 0
        
        for i in 0..<numberOfTries {
            let concurrentQueue = DispatchQueue(label: "com.dispatchCacheService.test\(i)", attributes: .concurrent)
            concurrentQueue.async {
                cacheManager.storeObject(key: 0, value: i)
            }
            
            concurrentQueue.async {
                cacheManager.getObject(key: 0) { object, error in
                    if let object = object {
                        counter += 1
                    }
                }
            }
        }
        
        XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(counter, numberOfTries)
    }
    
    func testOnMainThread() throws {
        let expectation = XCTestExpectation(description: #function)
        let cacheManager = MockCacheService<Int, String>()
        
        var result: String = ""
        
        DispatchQueue.main.async {
            cacheManager.storeObject(key: 0, value: "value")
        }
            
        DispatchQueue.main.async {
            cacheManager.getObject(key: 0) { object, error in
                if let object = object {
                    result = object
                }
            }
        }
        
        XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, "value")
    }
}
