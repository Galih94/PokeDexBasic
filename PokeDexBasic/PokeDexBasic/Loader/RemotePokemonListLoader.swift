//
//  RemotePokemonListLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import Alamofire
import Foundation

final class RemotePokemonListLoader: IPokemonListLoader {
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    typealias Result = IPokemonListLoader.Result
    private let apiService: IPokemonAPIService
    let dataComposer: IPokemonListDataComposer
    
    init(apiService: IPokemonAPIService, dataComposer: IPokemonListDataComposer) {
        self.apiService = apiService
        self.dataComposer = dataComposer
    }
    
    func load(completion: @escaping (Result) -> Void) {
        let url = dataComposer.getURL()
        requestApi(url) { [weak self] response in
            guard let self else {
                completion(.failure(Error.connectivity))
                return
            }
            switch response {
            case .success(let newPokemon):
                let allpokemon = self.dataComposer.getCurrentPokemons() + newPokemon
                self.dataComposer.setCurrentPokemons(allpokemon)
                completion(.success(allpokemon))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
        
    }
    
    private func requestApi(_ url: String, completion: @escaping (Result) -> Void) {
        apiService.request(url: url) { response in
            switch response {
            case .success(let data):
                completion(RemotePokemonListLoader.map(data: data))
            case .failure( _):
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(data: Data) -> Result {
        do {
            let items = try PokemonsMapper.map(data)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}


private extension Array where Element == RemotePokemon {
    func toModels() -> [Pokemon] {
        return map { pokemon in
            return Pokemon(name: pokemon.name, url: pokemon.url )
        }
    }
}

final class PokemonsMapper {
    
    private struct Roots: Decodable {
        let results: [RemotePokemon]
    }
    
    static func map(_ data: Data) throws -> [RemotePokemon] {
        guard let roots = try? JSONDecoder().decode(Roots.self, from: data) else {
            throw RemotePokemonListLoader.Error.invalidData
        }
        
        return roots.results
    }
}

