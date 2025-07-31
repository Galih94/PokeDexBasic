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
    
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result) -> Void) {
        let url = urlGenerator.getURL()
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(RemotePokemonListLoader.map(data: data))
            case .failure:
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
            let urlString = pokemon.url
            var replacedURL = urlString.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/")
            replacedURL.removeLast()
            let spriteURL = replacedURL + ".png"
            return Pokemon(name: pokemon.name, url: spriteURL )
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

