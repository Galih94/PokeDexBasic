//
//  PokemonListDataComposerSpy.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import XCTest
@testable import PokeDexBasic

final class PokemonListDataComposerSpy: IPokemonListDataComposer {
    
    private var pokemons: [Pokemon]
    
    init(pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }
    
    func getCurrentPokemons() -> [PokeDexBasic.Pokemon] {
        return pokemons
    }
    
    func getURL() -> String {
        return "https://test-url.com"
    }
    
    func setCurrentPokemons(_ pokemonList: [PokeDexBasic.Pokemon]) {
        pokemons = pokemonList
    }
    
}
