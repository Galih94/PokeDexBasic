//
//  PokemonListDataComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

final class PokemonListDataComposer: IPokemonListDataComposer {
    private let MAX_POKEMON_PER_FETCH = 10
    var pokemonList: [Pokemon]
    
    init(pokemonList: [Pokemon]) {
        self.pokemonList = pokemonList
    }
    
    func getURL() -> String {
        let res = "https://pokeapi.co/api/v2/pokemon?limit=\(MAX_POKEMON_PER_FETCH)&offset=\(pokemonList.count)"
        return res
    }
    
    func getCurrentPokemons() -> [Pokemon] {
        return pokemonList
    }
    
    func setCurrentPokemons(_ pokemonList: [Pokemon]) {
        self.pokemonList = pokemonList
    }
}

