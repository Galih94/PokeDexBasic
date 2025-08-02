//
//  HomeViewModelTests.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import XCTest
@testable import PokeDexBasic

final class HomeViewModelTests: XCTestCase {
    func testLoadPage() {
        let (sut, loader, _) = makeSUT(onTappedPokemon: { _ in }, onShowPokemonDetail: { _ in })
        
        sut.loadPage()
        XCTAssertEqual(sut.pokemons.value, [MockPokemon.obj])
        XCTAssertEqual(loader.requests, [.load("https://pokeapi.co/api/v2/pokemon?limit=10&offset=0", [])])
    }
    
    func testTapPokemon() {
        let exp = expectation(description: "Expected onTap called")
        let (sut, _, _) = makeSUT(onTappedPokemon: { _ in
            exp.fulfill()
        }, onShowPokemonDetail: { _ in })
        
        sut.onTappedPokemon?(MockPokemon.obj)
        wait(for: [exp], timeout: 1.0)
    }
    
    func testSearchPokemon() {
        let (sut, _, detailLoader) = makeSUT(onTappedPokemon: { _ in }, onShowPokemonDetail: { [weak self] pokemonDetail in
            self?.comparePokemonDetails(pokemonDetail, MockPokemonDetail.obj)
        })
        
        let name = "test"
        sut.searchPokemon(name)
        XCTAssertEqual(detailLoader.requests, [.load(name)])
        
        detailLoader.setResultCompletionSuccess = false
        let errorExpectation = expectation(description: "Expected onSearchError to be called")
        sut.onSearchError = {
            errorExpectation.fulfill()
        }
        sut.searchPokemon(name)
        XCTAssertEqual(detailLoader.requests, [.load(name), .load(name)])
        wait(for: [errorExpectation], timeout: 1.0)
    }
    
    // MARK: - Helpers
    private func makeSUT(onTappedPokemon: ((Pokemon) -> Void)?,
                         onShowPokemonDetail: ((PokemonDetail) -> Void)?,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (HomeViewModel, PokemonListLoaderSpy, PokemonDetailLoaderSpy) {
        let detailLoader = PokemonDetailLoaderSpy()
        let dataComposer = PokemonListDataComposer(pokemonList: [])
        let loader = PokemonListLoaderSpy(dataComposer: dataComposer)
        let sut = HomeViewModel(detailLoader: detailLoader, loader: loader, onTappedPokemon: onTappedPokemon, onShowPokemonDetail: onShowPokemonDetail)
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(loader, file: file, line: line)
        trackForMemoryLeak(detailLoader, file: file, line: line)
        
        return (sut, loader, detailLoader)
    }
}


