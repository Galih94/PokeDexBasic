//
//  XCTestCase+Ext.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//


import XCTest

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have beed deallocated, potential memory leak", file: file, line: line)
        }
    }
    
}

