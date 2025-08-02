//
//  DetailViewModelTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import XCTest
@testable import PokeDexBasic

final class DetailViewModelTests: XCTestCase {
    let pokemonName = "test"
    
    func testLoadDetails() {
        let (sut, loader) = makeSUT(name: pokemonName, defaultPokemonDetail: nil, onBackTapped: { })
        comparePokemonDetails(try? sut.pokemonDetail.value(), nil)
        
        sut.loadDetails()
        XCTAssertEqual(loader.requests, [.load(pokemonName)])
        comparePokemonDetails(try? sut.pokemonDetail.value(), MockPokemonDetail.obj)
    }
    
    func testLoadDefaultDetails() {
        let (sut, loader) = makeSUT(name: pokemonName, defaultPokemonDetail: MockPokemonDetail.obj, onBackTapped: { })
        comparePokemonDetails(try? sut.pokemonDetail.value(), MockPokemonDetail.obj)
        
        sut.loadDetails()
        XCTAssertEqual(loader.requests, [])
    }
    
    func testTapBack() {
        let exp = expectation(description: "Expected onTap called")
        let (sut, _) = makeSUT(name: pokemonName, defaultPokemonDetail: nil, onBackTapped: {
            exp.fulfill()
        })
        sut.onBackTapped?()
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    private func makeSUT(name: String, defaultPokemonDetail: PokemonDetail?, onBackTapped: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) -> (DetailViewModel, PokemonDetailLoaderSpy) {
        let loader = PokemonDetailLoaderSpy()
        let sut = DetailViewModel(loader: loader, pokemonName: name, onBackTapped: onBackTapped, defaultPokemonDetail: defaultPokemonDetail)
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(loader, file: file, line: line)
        
        return (sut, loader)
    }
}
