//
//  PokemonListComposerTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


import XCTest
@testable import PokeDexBasic

final class PokemonListComposerTests: XCTestCase {
    
    func testGetURL() {
        let sut = makeSUT()
        XCTAssertEqual(sut.getURL([]), "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")
        XCTAssertEqual(sut.getURL(generatePokemons(10)), "https://pokeapi.co/api/v2/pokemon?limit=10&offset=10")
        XCTAssertEqual(sut.getURL(generatePokemons(20)), "https://pokeapi.co/api/v2/pokemon?limit=10&offset=20")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> PokemonListURLComposer {
        let sut = PokemonListURLComposer()
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
    
    private func generatePokemons(_ count: Int) -> [Pokemon] {
        var result = [Pokemon]()
        for _ in 0..<count {
            result.append(Pokemon(name: "test", url: "https://test-url.com"))
        }
        return result
    }
}
