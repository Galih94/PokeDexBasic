//
//  PokemonDetailLoaderTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 01/08/25.
//


import XCTest
@testable import PokeDexBasic

final class PokemonDetailLoaderTests: XCTestCase {
    
    func testLoad() {
        let sut = makeSUT()
        XCTAssertEqual(sut.requests, [])
        sut.load(name: "test", completion: {_ in })
        XCTAssertEqual(sut.requests, [.load("test")])
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> PokemonDetailLoaderSpy {
        let sut = PokemonDetailLoaderSpy()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
    
    enum PokemonDetailLoaderRequests: Equatable  {
        case load(String)
    }
    
    final class PokemonDetailLoaderSpy: IPokemonDetailLoader {
        var requests: [PokemonDetailLoaderRequests] = []
        
        func load(name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
            requests.append(.load(name))
        }
        
    }

}
