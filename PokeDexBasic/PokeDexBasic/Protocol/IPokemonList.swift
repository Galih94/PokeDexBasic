//
//  IPokemonList.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//


protocol IPokemonListDataComposer {
    func getURL() -> String
    func getCurrentPokemons() -> [Pokemon]
    func setCurrentPokemons(_ pokemonList: [Pokemon])
}

protocol IPokemonListLoader {
    typealias Result = Swift.Result<[Pokemon], Error>
    func load(completion: @escaping (Result) -> Void)
}

extension MainQueueDispatchDecorator: IPokemonListLoader where T == IPokemonListLoader {
    func load(completion: @escaping (IPokemonListLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
