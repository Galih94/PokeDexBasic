//
//  IPokemonList.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


protocol IPokemonListURLComposer {
    func getURL(_ pokemonList: [Pokemon]) -> String
}

protocol IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

