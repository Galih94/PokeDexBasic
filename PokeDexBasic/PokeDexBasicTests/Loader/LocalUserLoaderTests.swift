//
//  LocalUserLoaderTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 29/07/25.
//

import XCTest
@testable import PokeDexBasic

final class LocalUserLoaderTests: XCTestCase {
    
    func testSaveLoadDeleteCalled() {
        let sut = makeSUT()
        XCTAssertEqual(sut.requests, [])
        
        sut.save(User(name: "Test User"))
        XCTAssertEqual(sut.requests, [.save(User(name: "Test User"))])
        
        let _ = sut.load()
        XCTAssertEqual(sut.requests, [.save(User(name: "Test User")), .load])
        
        let _ = sut.delete()
        XCTAssertEqual(sut.requests, [.save(User(name: "Test User")), .load, .delete])
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> LocalUserDataSpy {
        let sut = LocalUserDataSpy()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
}
