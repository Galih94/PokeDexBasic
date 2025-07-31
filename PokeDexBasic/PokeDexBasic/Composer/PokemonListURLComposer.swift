//
//  PokemonListURLComposer.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

final class PokemonListURLComposer: IPokemonListURLComposer {
    private let MAX_POKEMON_PER_FETCH = 10
    let pokemonList: [Pokemon]
    
    init(pokemonList: [Pokemon]) {
        self.pokemonList = pokemonList
    }
    
    func getURL() -> String {
        return "https://pokeapi.co/api/v2/pokemon?limit=\(MAX_POKEMON_PER_FETCH)&offset=\(pokemonList.count)"
    }
}

