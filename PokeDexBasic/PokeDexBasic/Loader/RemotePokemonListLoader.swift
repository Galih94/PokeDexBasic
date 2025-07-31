//
//  RemotePokemonListLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import Alamofire
import Foundation

final class RemotePokemonListLoader: IPokemonListLoader {
    func load(_ urlGenerator: IPokemonListURLComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = urlGenerator.getURL()
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode([RemotePokemon].self, from: data)
                    let newPokemonList = decoded.map {$0.mapToPokemon()}
                    let all = urlGenerator.getCurrentPokemons() + newPokemonList
                    
                    completion(.success(all))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
