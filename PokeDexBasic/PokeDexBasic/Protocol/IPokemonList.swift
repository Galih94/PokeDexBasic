//
//  IPokemonList.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


protocol IPokemonListURLComposer {
    func getURL() -> String
}

protocol IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

