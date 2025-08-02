//
//  LocalPokemonDetailLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RealmSwift

final class LocalPokemonDetailLoader: IPokemonDetailLoader {
    private let realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
        }
    }
    
    func load(name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(RealmPokemonDetail.self)
            let pokemonDetails: [PokemonDetail] = results.map { $0.mapToPokemonDetail() }
            if let pokemonDetail = pokemonDetails.first(where: { $0.name.lowercased() == name.lowercased() }) {
                completion(.success(pokemonDetail))
            } else {
                completion(.failure(RemotePokemonDetailLoader.Error.notFoundPokemon))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

extension LocalPokemonDetailLoader: IPokemonDetailSaveLocal {
    func save(_ pokemonDetail: PokemonDetail) {
        guard let realm else { return }

        do {
            let existingObjects = realm.objects(RealmPokemonDetail.self)
            var existingDetails = Array(existingObjects.map { $0.mapToPokemonDetail() })

            if let index = existingDetails.firstIndex(where: { $0.name.lowercased() == pokemonDetail.name.lowercased() }) {
                existingDetails[index] = pokemonDetail
            } else {
                existingDetails.append(pokemonDetail)
            }

            let realmObjects = existingDetails.map { RealmPokemonDetail(from: $0) }

            try realm.write {
                realm.delete(existingObjects)
                realm.add(realmObjects)
            }
        } catch {
            print("Error save Pokémon detail: \(error)")
        }
    }
}
