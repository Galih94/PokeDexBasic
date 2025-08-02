//
//  Pokemon.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

import RealmSwift

struct Pokemon: Equatable {
    let name: String
    let url: String
}

struct RemotePokemon: Codable, Equatable {
    let name: String
    let url: String
}

class RealmPokemon: Object {
    @Persisted var name: String
    @Persisted var url: String

    func mapToPokemon() -> Pokemon {
        return Pokemon(name: name, url: url)
    }
}
