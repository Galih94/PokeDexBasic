//
//  LoginViewModelTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 30/07/25.
//

import XCTest
@testable import PokeDexBasic

final class LoginViewModelTests: XCTestCase {
    func testSaveLoadDeleteCalled() {
        let (sut, loader) = makeSUT(onRegisterSuccess: {})
        sut.register("test name")
        
        XCTAssertEqual(loader.requests, [.save(User(name: "test name"))])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(onRegisterSuccess: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) -> (LoginViewModel, LocalUserDataSpy) {
        let loader = LocalUserDataSpy()
        let sut = LoginViewModel(loader: loader, onRegisterSuccess: onRegisterSuccess)
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(loader, file: file, line: line)
        
        return (sut, loader)
    }
}
