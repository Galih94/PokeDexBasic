//
//  XCTestCase+Ext.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//


import XCTest
@testable import PokeDexBasic

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have beed deallocated, potential memory leak", file: file, line: line)
        }
    }
    
    func comparePokemonDetails(_ result: PokemonDetail?, _ expResult: PokemonDetail?, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(result?.name, expResult?.name, file: file, line: line)
        XCTAssertEqual(result?.imageURL, expResult?.imageURL, file: file, line: line)
        XCTAssertEqual(result?.abilities, expResult?.abilities, file: file, line: line)
        
    }
    
}

