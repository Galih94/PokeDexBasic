//
//  FallbackPokemonDetailLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


final class FallbackPokemonDetailLoader: IPokemonDetailLoader {
    let remote: IPokemonDetailLoader
    let local: IPokemonDetailLoader
    
    init(remote: IPokemonDetailLoader, local: IPokemonDetailLoader) {
        self.remote = remote
        self.local = local
    }
    
    func load(name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        remote.load(name: name) { [weak self] response in
            switch response {
            case .success( let result):
                if let objSaveLocal = self?.local as? IPokemonDetailSaveLocal {
                    objSaveLocal.save(result)
                }
                completion(.success(result))
            case .failure( let error):
                self?.local.load(name: name) { localResult in
                    switch localResult {
                    case .success(let localPokemonDetail):
                        completion(.success(localPokemonDetail))
                    default:
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}