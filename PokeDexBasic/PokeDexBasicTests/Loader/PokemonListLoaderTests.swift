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
        let mockURLComposer = MockPokemonListURLComposer()
        
        XCTAssertEqual(sut.load(mockURLComposer), [])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> IPokemonListLoader {
        let sut = RemotePokemonListLoader()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
    
    final class MockPokemonListURLComposer: IPokemonListURLComposer {
        func getURL(_ pokemonList: [PokeDexBasic.Pokemon]) -> String {
            return "https://test-url.com"
        }
    }
}
