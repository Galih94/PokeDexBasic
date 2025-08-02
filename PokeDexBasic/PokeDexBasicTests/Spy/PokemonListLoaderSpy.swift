//
//  PokemonListLoaderSpy.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import XCTest
@testable import PokeDexBasic

enum MockPokemon {
    static let obj: Pokemon = Pokemon(name: "test pokemon name", url: "https://test-url.com")
}

enum PokemonListLoaderRequests: Equatable  {
    case load(String, [Pokemon])
}

final class PokemonListLoaderSpy: IPokemonListLoader {
    var requests: [PokemonListLoaderRequests] = []
    
    func load(_ urlGenerator: IPokemonListDataComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        requests.append(.load(urlGenerator.getURL(), urlGenerator.getCurrentPokemons()))
        completion(.success([MockPokemon.obj]))
    }
    
}
