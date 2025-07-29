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
    enum LocalUserRequests: Equatable  {
        case save(User), load, delete
        static func == (lhs: LocalUserRequests, rhs: LocalUserRequests) -> Bool {
            switch (lhs, rhs) {
            case let (.save(lhsUser), .save(rhsUser)):
                return lhsUser == rhsUser
            case (.load, .load), (.delete, .delete):
                return true
            default:
                return false
            }
        }
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> LocalUserDataSpy {
        let sut = LocalUserDataSpy()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
    
    class LocalUserDataSpy: ILocalUser {
        
        var currentUser: User?
        var requests: [LocalUserRequests] = []

        func save(_ user: User) {
            currentUser = user
            requests.append(.save(user))
        }

        func load() -> User? {
            requests.append(.load)
            return currentUser
        }
        
        func delete() {
            currentUser = nil
            requests.append(.delete)
        }
    }
}
