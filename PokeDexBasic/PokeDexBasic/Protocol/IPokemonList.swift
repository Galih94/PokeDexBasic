//
//  IPokemonList.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


protocol IPokemonListURLComposer {
    func getURL() -> String
    func getCurrentPokemons() -> [Pokemon]
}

protocol IPokemonListLoader {
    typealias Result = Swift.Result<[Pokemon], Error>
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result) -> Void)
}

