//
//  ProfileViewModelTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//


import XCTest
@testable import PokeDexBasic

final class ProfileViewModelTests: XCTestCase {
    func testGetNameCalled() {
        let (sut, loader) = makeSUT()
        
        XCTAssertEqual(loader.requests, [], "Expected no call")
        
        let _ = sut.getName()
        XCTAssertEqual(loader.requests, [.load], "Expected load")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (ProfileViewModel, LocalUserDataSpy) {
        let loader = LocalUserDataSpy()
        let sut = ProfileViewModel(loader: loader)
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(loader, file: file, line: line)
        
        return (sut, loader)
    }
}
