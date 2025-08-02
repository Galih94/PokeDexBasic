//
//  LocalPokemonListLoader.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 02/08/25.
//


import RealmSwift

protocol IPokemonListSaveLocal {
    func save(_ pokemons: [Pokemon])
}

final class LocalPokemonListLoader: IPokemonListLoader {
    private let realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
        }
    }
    
    func load(_ urlGenerator: IPokemonListDataComposer, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(RealmPokemon.self)
            let pokemons: [Pokemon] = results.map { $0.mapToPokemon() }
            
            completion(.success(pokemons))
        } catch {
            completion(.failure(error))
        }
    }
}

extension LocalPokemonListLoader: IPokemonListSaveLocal {
    func save(_ pokemons: [Pokemon]) {
        guard let realm else { return }
        
        do {
            try realm.write {
                realm.delete(realm.objects(RealmPokemon.self))
                
                for pokemon in pokemons {
                    let realmPokemon = RealmPokemon()
                    realmPokemon.name = pokemon.name
                    realmPokemon.url = pokemon.url
                    realm.add(realmPokemon)
                }
            }
        } catch {
            print("Realm Failed to save pokemon list: \(error.localizedDescription)")
        }
    }
    
}


