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
        let sutZeroPokemon = makeSUT(pokemonList: generatePokemons(0))
        XCTAssertEqual(sutZeroPokemon.getURL(), "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")
        
        let sutTenPokemon = makeSUT(pokemonList: generatePokemons(10))
        XCTAssertEqual(sutTenPokemon.getURL(), "https://pokeapi.co/api/v2/pokemon?limit=10&offset=10")
    }
    
    func testGetCurrentPokemonList() {
        let sutZeroPokemon = makeSUT(pokemonList: generatePokemons(0))
        XCTAssertEqual(sutZeroPokemon.getCurrentPokemons(), [])
        
        let tenPokemon = generatePokemons(10)
        let sutTenPokemon = makeSUT(pokemonList: tenPokemon)
        XCTAssertEqual(sutTenPokemon.getCurrentPokemons(), tenPokemon)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(pokemonList: [Pokemon], file: StaticString = #filePath, line: UInt = #line) -> PokemonListURLComposer {
        let sut = PokemonListURLComposer(pokemonList: pokemonList)
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
