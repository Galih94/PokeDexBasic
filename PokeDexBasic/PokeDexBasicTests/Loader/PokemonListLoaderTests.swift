//
//  PokemonListLoaderTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


import XCTest
@testable import PokeDexBasic


protocol IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer) -> [Pokemon]
}

final class RemotePokemonListLoader: IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer) -> [Pokemon] {
        return []
    }
}

final class PokemonListLoaderTests: XCTestCase {
    
    func testLoad() {
        let sut = makeSUT()
        XCTAssertEqual(sut.requests, [])
        
        let mockURLComposer = MockPokemonListURLComposer()
        let _ = sut.load(mockURLComposer)
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
        
        func load(_ urlGenerator: IPokemonListURLComposer) -> [Pokemon] {
            requests.append(.load(urlGenerator.getURL([])))
            return []
        }
    }

}
