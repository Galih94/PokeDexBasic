//
//  Pokemon.swift
//  PokeDexBasic
//
//  Created by Galih Samudra on 31/07/25.
//

struct Pokemon: Equatable {
    let name: String
    let url: String
}

struct RemotePokemon: Codable, Equatable {
    let name: String
    let url: String
    
    func mapToPokemon() -> Pokemon {
        return Pokemon(name: name, url: url)
    }
}
