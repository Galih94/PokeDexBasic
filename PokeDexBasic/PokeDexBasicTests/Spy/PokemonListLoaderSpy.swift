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
    let dataComposer: IPokemonListDataComposer
    
    init(dataComposer: IPokemonListDataComposer) {
        self.dataComposer = dataComposer
    }
    
    func load(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        requests.append(.load(dataComposer.getURL(), dataComposer.getCurrentPokemons()))
        completion(.success([MockPokemon.obj]))
    }
    
}
