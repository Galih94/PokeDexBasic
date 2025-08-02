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
        
        let spyDataComposer = PokemonListDataComposerSpy(pokemons: [])
        let sut = makeSUT(dataComposer: spyDataComposer)
        XCTAssertEqual(sut.requests, [])
        
        sut.load(completion: {_ in })
        XCTAssertEqual(sut.requests, [.load("https://test-url.com", [])])
        XCTAssertEqual(spyDataComposer.getCurrentPokemons(), [])
    }
    
    // MARK: - Helpers
    private func makeSUT(dataComposer: IPokemonListDataComposer, file: StaticString = #filePath, line: UInt = #line) -> PokemonListLoaderSpy {
        let sut = PokemonListLoaderSpy(dataComposer: dataComposer)
        trackForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
}
