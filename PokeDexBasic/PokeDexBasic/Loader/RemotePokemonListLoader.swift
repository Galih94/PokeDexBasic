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
    
    func load(_ dataComposer: IPokemonListDataComposer, completion: @escaping (Result) -> Void) {
        let url = dataComposer.getURL()
        print("res is", url)
        requestApi(url) { response in
            switch response {
            case .success(let newPokemon):
                let allpokemon = dataComposer.getCurrentPokemons() + newPokemon
                print("res is 1 \(allpokemon.count)")
                completion(.success(allpokemon))
            case .failure:
                print("res is error")
                completion(.failure(Error.connectivity))
            }
        }
        
    }
    
    private func requestApi(_ url: String, completion: @escaping (Result) -> Void) {
        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completion(RemotePokemonListLoader.map(data: data))
            case .failure(let errorApi):
                print("res is errorApi \(errorApi)")
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

