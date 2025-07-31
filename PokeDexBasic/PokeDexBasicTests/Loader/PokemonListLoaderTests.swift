//
//  PokemonListLoaderTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


import XCTest
@testable import PokeDexBasic

final class PokemonListLoaderTests: XCTestCase {
    
    func testLoad() {
        let sut = makeSUT()
        XCTAssertEqual(sut.requests, [])
        
        let mockURLComposer = MockPokemonListURLComposer()
        sut.load(mockURLComposer, completion: {_ in })
        XCTAssertEqual(sut.requests, [.load("https://test-url.com")])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> PokemonListLoaderSpy {
        let sut = PokemonListLoaderSpy()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
    
    final class MockPokemonListURLComposer: IPokemonListURLComposer {
        func getURL(_ pokemonList: [PokeDexBasic.Pokemon]) -> String {
            return "https://test-url.com"
        }
    }
    
    enum PokemonListLoaderRequests: Equatable  {
        case load(String)
    }
    
    final class PokemonListLoaderSpy: IPokemonListLoader {
        var requests: [PokemonListLoaderRequests] = []
        
        func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
            requests.append(.load(urlGenerator.getURL([])))
        }
    }

}
