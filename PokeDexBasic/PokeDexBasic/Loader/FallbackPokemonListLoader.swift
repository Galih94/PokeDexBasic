//
//  FallbackPokemonListLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


final class FallbackPokemonListLoader: IPokemonListLoader {
    let remote: IPokemonListLoader
    let local: IPokemonListLoader
    
    init(remote: IPokemonListLoader, local: IPokemonListLoader) {
        self.remote = remote
        self.local = local
    }
    
    func load(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        remote.load { [weak self] response in
            switch response {
            case .success( let result):
                if let objSaveLocal = self?.local as? IPokemonListSaveLocal {
                    objSaveLocal.save(result)
                }
                completion(.success(result))
            case .failure( let error):
                self?.local.load { localResult in
                    switch localResult {
                    case .success(let localPokemons) where !localPokemons.isEmpty:
                        completion(.success(localPokemons))
                    default:
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}




